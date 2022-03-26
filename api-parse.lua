local lunajson = require('lunajson')
local lfs = require('lfs')
local lxsh = require 'lxsh'
local inspect = require('inspect')
local serpent = require('serpent')
local https = require('ssl.https')

-- Hack needed for act-boy debugger until I figure out a way to set the CWD correctly through config
lfs.chdir(arg[0]:gsub('api%-parse%.lua', ''))

local api
do -- Decode the api file check for local cache first
    lfs.mkdir('.io')
    local api_url = 'https://lua-api.factorio.com/next/runtime-api.json'
    local api_file = io.open('.io/runtime-api.json', 'r')
    if not api_file then
        local api_from_web = assert(https.request(api_url))
        api_file = assert(io.open('.io/runtime-api.json', 'w'))
        api_file:write(api_from_web)
        api_file:flush()
    end

    api = lunajson.decode(api_file:read('*a'))
    api_file:close()
end

local function write_output_file(output_file_name, key, stds)
    local outfile = assert(io.open(output_file_name, 'w'))
    outfile:write(key)
    outfile:write(inspect(stds))
    outfile:flush()
    os.execute('lua-format -i ' .. output_file_name) -- Can we do this without a file?
    outfile:close()
end

local function dump_defines(tab)
    local output_file_name = '.io/defines.lua'
    local outfile = assert(io.open(output_file_name, 'w'))
    outfile:write(serpent.dump(tab, {name = 'defines'}))
    outfile:flush()
    os.execute('lua-format -i ' .. output_file_name) -- Can we do this without a file?
    outfile:close()
end

do -- Parse and write out the defines into luacheck format
    local stds = { read_globals = { defines = { fields = {} } } }
    local lua_defines = {}
    local fields = stds.read_globals.defines.fields

    stds.__VERSION = api.application_version
    local function parse_defines_stds(tab, cur_fields)
        for _, define in pairs(tab) do
            if define.name == 'prototypes' then
                cur_fields['prototypes'] = { other_fields = true }
            elseif define.values or define.subkeys then
                cur_fields[define.name] = { fields = {} }
                parse_defines_stds(define.values or define.subkeys, cur_fields[define.name].fields)
            else
                cur_fields[#cur_fields + 1] = define.name
            end
        end
    end
    parse_defines_stds(api.defines, fields)

    local function parse_defines(tab, next_key)
        for index, define in pairs(tab) do
            if define.values or define.subkeys then
                next_key[define.name] = {}
                parse_defines(define.values or define.subkeys, next_key[define.name])
            else
                if define.name == 'prototypes' then
                    next_key['prototypes'] = {}
                else
                    next_key[define.name] = define.order
                end
            end
        end
    end
    parse_defines(api.defines, lua_defines)

    dump_defines(lua_defines)

    -- Deprecated STDLIB
    fields.color = { other_fields = true }
    fields.anticolor = { other_fields = true }
    fields.lightcolor = { other_fields = true }
    fields.time = { 'second', 'minute', 'day', 'week', 'month', 'year' }

    write_output_file('.io/stds_defines.lua', 'stds.factorio_defines = ', stds)
end

do -- Classes
    local classes = { 'LuaGameScript', 'LuaBootstrap', 'LuaRendering', 'LuaRCON', 'LuaCommandProcessor', 'LuaSettings', 'LuaRemote' }

    local function output_class_data(class, stds)
        if class.methods then
            for _, method in pairs(class.methods) do
                stds.fields[#stds.fields + 1] = method.name
            end
        end
        if class.attributes then
            for _, attribute in pairs(class.attributes) do
                -- api.classes[40].attributes[] name read write type/complex_type
                if attribute.name == 'object_name' then
                    stds.fields[#stds.fields + 1] = attribute.name
                else
                    stds.fields[attribute.name] = {}
                    local field = stds.fields[attribute.name]

                    if attribute.write then
                        field.read_only = false
                    end

                    if type(attribute.type) == 'table' then
                        for _, param in pairs(attribute.type.parameters or {}) do
                            field.fields = field.fields or {}
                            field.fields[#field.fields + 1] = param.name
                        end
                        if attribute.type.complex_type ~= 'table' then
                            field.other_fields = true
                        end
                    elseif attribute.type:find('^Lua') or attribute.type:find('Settings') then
                        field.other_fields = true
                    end
                end
            end
        end
    end

    for _, classname in pairs(classes) do
        for _, class in pairs(api.classes) do
            if class.name == classname then
                local stds = { fields = {} }
                output_class_data(class, stds)
                write_output_file('.io/' .. classname .. '.lua', classname .. ' = ', stds)
                break
            end
        end
    end
end

do -- Read .luacheckrc and write output file
    local function count_operators()
        local function counter(line)
            local open, close = 0, 0
            for kind, text in lxsh.lexers.lua.gmatch(line) do
                if kind == 'operator' then
                    if text == '{' then
                        open = open + 1
                    elseif text == '}' then
                        close = close + 1
                    end
                end
            end
            return open, close
        end
        return counter, 0, 0
    end

    local function replace_key(key_pattern, input_file_name, output_file_name)
        local contents = {}
        local in_block
        local luacheckrc = assert(io.open('.luacheckrc', 'r+'))
        local input_file = assert(io.open(input_file_name, 'r+'))
        local counter, open, close = count_operators()
        for line in luacheckrc:lines('*l') do
            if line:find(key_pattern) then
                in_block = true
                open, close = counter(line)
            elseif in_block then
                open, close = counter(line)
                if close >= open then
                    in_block = false
                    for outputline in input_file:lines('*l') do
                        contents[#contents + 1] = outputline .. '\r'
                    end
                    input_file:close()
                end
            elseif not in_block then
                contents[#contents + 1] = line
            end
        end
        luacheckrc:close()

        local output_file = assert(io.open(output_file_name, 'w'))
        output_file:write(table.concat(contents, ''))
        output_file:flush()
        output_file:close()
        -- os.execute('lua-format -i ' .. output_file_name)
    end

    -- replace_key('stds.factorio_defines =', '.io/stds_defines.lua', '.luacheckrc')
    -- replace_key('LuaGameScript =', '.io/LuaGameScript.lua', '.luacheckrc')
    -- replace_key('LuaBootstrap =', '.io/LuaBootstrap.lua', '.luacheckrc')
    -- replace_key('LuaCommandProcessor =', '.io/LuaCommandProcessor.lua', '.luacheckrc')
    -- replace_key('LuaRCON =', '.io/LuaRCON.lua', '.luacheckrc')
    -- replace_key('LuaSettings =', '.io/LuaSettings.lua', '.luacheckrc')
    -- replace_key('LuaRemote =', '.io/LuaRemote.lua', '.luacheckrc')
    -- replace_key('LuaRendering =', '.io/LuaRendering.lua', '.luacheckrc')
end
