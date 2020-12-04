-- luacheck: globals io
local inspect = require('__stdlib__/stdlib/vendor/inspect')
local defines = require('__stdlib__/faketorio/defines')
defines.time = require('__stdlib__/stdlib/utils/defines/time')

local stds = {
    read_globals = {
        defines = {
            fields = {
                color = {
                    other_fields = true
                },
                anticolor = {
                    other_fields = true
                },
                lightcolor = {
                    other_fields = true
                }
            }
        }
    }
}

local fields = stds.read_globals.defines.fields

local function parse(_defines, _field)
    for key, value in pairs(_defines) do
        if type(value) == 'table' then
            _field[key] = {
                fields = {}
            }
            parse(_defines[key], _field[key].fields)
        else
            _field[#_field + 1] = key
        end
    end
end

parse(defines, fields)

local file = io.open('defines.luacheckrc.lua', 'w')
file:write('stds.factorio_defines = ')
file:write(inspect(stds))
file:close()
os.execute('lua-format -i defines.luacheckrc.lua')
