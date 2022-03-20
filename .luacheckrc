--[[----------------------------------------------------------------------------
                            LICENSE
    .luacheckrc for Factorio Version 0.18.8, luacheck version 0.23.0
    This file is free and unencumbered software released into the public domain.

    Anyone is free to copy, modify, publish, use, compile, sell, or
    distribute this file, either in source code form or as a compiled
    binary, for any purpose, commercial or non-commercial, and by any
    means.

    In jurisdictions that recognize copyright laws, the author or authors
    of this file dedicate any and all copyright interest in the
    software to the public domain. We make this dedication for the benefit
    of the public at large and to the detriment of our heirs and
    successors. We intend this dedication to be an overt act of
    relinquishment in perpetuity of all present and future rights to this
    software under copyright law.

    THE FILE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
    IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
    OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
    ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
    OTHER DEALINGS IN THE SOFTWARE.

    For more information, please refer to <http://unlicense.org/>
----------------------------------------------------------------------------]] --
local LINE_LENGTH = false
local IGNORE = { '111/__', '21./%w+_$', '21./^_[_%w]+$', '213/^%a$', '213/index', '213/key', '11[12]/[Tt]est[%w_]+' }
local NOT_GLOBALS = { 'coroutine', 'io', 'socket', 'dofile', 'loadfile' }

local FACTORIO_CONTROL = 'lua52+factorio+factorio_control+stdlib+factorio_defines'
local FACTORIO_DATA = 'lua52+factorio+factorio_data+stdlib+stdlib_data+factorio_defines+factorio_base_data_common'

-- For Base and Core Mods
local STD_BASE_DATA = 'lua52+factorio+factorio_data+factorio_defines+factorio_base_data'
local STD_BASE_CONTROL = 'lua52+factorio+factorio_control+factorio_defines+factorio_base_control'

do -- Setup
    do -- Setup luacheck rc defaults
        std = FACTORIO_CONTROL -- Assume Factorio Control Stage as Default
        not_globals = NOT_GLOBALS
        ignore = IGNORE
        quiet = 1
        max_cyclomatic_complexity = false
        codes = true
        max_line_length = LINE_LENGTH
        max_code_line_length = LINE_LENGTH
        max_string_line_length = LINE_LENGTH
        max_comment_line_length = LINE_LENGTH

        -- List of files and directories to exclude
        exclude_files = {
            '**/.trash/', '**/.history/', '**/stdlib/vendor/', -- Ignore special folders
            '**/combat-tester/', '**/test-maker/', '**/trailer/', -- Ignore development mods
            '**/love/includes/', -- Ignore love Includes
            '**/luaunit.lua' -- Ignore luaunit 'executable'--
        }
    end

    do -- Set default prototype files
        files['**/data.lua'].std = FACTORIO_DATA
        files['**/data-updates.lua'].std = FACTORIO_DATA
        files['**/data-final-fixes.lua'].std = FACTORIO_DATA
        files['**/settings.lua'].std = FACTORIO_DATA
        files['**/settings-updates.lua'].std = FACTORIO_DATA
        files['**/settings-final-fixes.lua'].std = FACTORIO_DATA
        files['**/prototypes/'].std = FACTORIO_DATA
        files['**/data/'].std = FACTORIO_DATA
        files['**/settings/'].std = FACTORIO_DATA
        files['**/instrument-after-data.lua'].std = FACTORIO_DATA
        files['**/compatibility/'].std = FACTORIO_DATA
        files['**/lib/data*'].std = FACTORIO_DATA
    end

    do -- Base and Core mod files
        local base_scenarios = {
            std = STD_BASE_CONTROL .. '+factorio_base_scenarios+factorio_base_story',
            -- ignore = {'212/event', '111', '112', '113', '211', '212', '213', '311', '411', '412', '421', '422', '423', '431', '432', '512'}
            ignore = { '...' }
        }
        files['**/base/scenarios/'] = base_scenarios
        files['**/base/tutorials/'] = base_scenarios
        files['**/base/campaigns/'] = base_scenarios
        files['**/wip-scenario/'] = base_scenarios

        files['**/base/migrations/'] = { std = STD_BASE_CONTROL }

        files['**/core/lualib/'] = { std = STD_BASE_CONTROL }
        files['**/core/lualib/util.lua'] = { globals = { 'util', 'table' }, ignore = { '432/object' } }
        files['**/core/lualib/silo-script.lua'] = { ignore = { '4../player' } }
        files['**/core/lualib/production-score.lua'] = { ignore = { '4../player' } }
        files['**/core/lualib/story*'] = { std = '+factorio_base_story', ignore = { '42./k', '42./filter' } }
        files['**/core/lualib/builder.lua'] = { globals = { 'Builder', 'builder', 'action', 'down', 'right' } }

        files['**/core/lualib/bonus-gui-ordering.lua'] = { std = STD_BASE_DATA }
        files['**/core/lualib/collision-mask-util.lua'] = { std = STD_BASE_DATA }
        files['**/core/lualib/dataloader.lua'] = { globals = { 'data' } }
        files['**/core/lualib/circuit-connector-*'] = { std = STD_BASE_DATA .. '+factorio_circuit_connector_generated' }
        files['**/core/lualib/bonus-gui-ordering.lua'] = { globals = { 'bonus_gui_ordering' } }

        files['**/base/prototypes/'] = { std = STD_BASE_DATA }
        files['**/core/prototypes/'] = { std = STD_BASE_DATA }
        files['**/core/prototypes/noise-programs.lua'] = { ignore = { '212/x', '212/y', '212/tile', '212/map' } }
    end

    do -- Stdlib Files
        local stdlib_control = { std = 'lua52+factorio+factorio_control+stdlib+factorio_defines', max_line_length = LINE_LENGTH }
        local stdlib_data = { std = 'lua52+factorio+factorio_data+stdlib+factorio_defines', max_line_length = LINE_LENGTH }

        files['**/stdlib/'] = stdlib_control -- Assume control stage for stdlib
        files['**/stdlib/utils/**'].std = 'lua52+stdlib'
        files['**/stdlib/data/'] = stdlib_data
        files['**/spec/**'] = { globals = { 'serpent', 'log', 'package.remove_stdlib' }, std = 'lua52c+busted+factorio_defines+factorio_control+stdlib' }
        files['**/tools/love/'].std = 'luajit+love+stdlib_love+stdlib+stdlib_data'
    end
end

do -- Factorio STDs

    local util, LuaGameScript, LuaBootstrap, LuaRendering, LuaSettings, LuaRCON, LuaRemote, LuaCommandProcessor
    do -- local vars
        local util = {
            fields = {
                'multiplystripes', 'remove_safe', 'mix_color', 'list_to_map', 'combine_icons', 'conditional_return', 'mul_shift', 'draw_as_glow',
                'parse_energy', 'string_starts_with', 'by_pixel', 'foreach_sprite_definition', 'distance', 'insert_safe', 'split', 'copy',
                'technology_icon_constant_range', 'add_shift', 'premul_color', 'split_whitespace', 'empty_sprite', 'remove_from_list', 'increment',
                'remove_tile_references', 'oppositedirection', 'technology_icon_constant_followers', 'technology_icon_constant_braking_force',
                'technology_icon_constant_damage', 'positiontostr', 'technology_icon_constant_mining', 'technology_icon_constant_productivity', 'by_pixel_hr',
                'technology_icon_constant_capacity', 'product_amount', 'color', 'get_color_with_alpha', 'clamp', 'technology_icon_constant_equipment',
                'technology_icon_constant_movement_speed', 'technology_icon_constant_speed', 'merge', 'get_walkable_tile', 'moveposition', 'online_players',
                'technology_icon_constant_stack_size', 'multiply_color', 'format_number', 'add_shift_offset', 'formattime'
            }
        }
        util.fields.table = { fields = { 'compare', 'deepcopy' } }

        LuaGameScript = {
            fields = {
                'auto_save',
                'ban_player',
                'check_consistency',
                'check_prototype_translations',
                'count_pipe_groups',
                'create_force',
                'create_inventory',
                'create_profiler',
                'create_random_generator',
                'create_surface',
                'decode_string',
                'delete_surface',
                'direction_to_string',
                'disable_replay',
                'disable_tutorial_triggers',
                'encode_string',
                'evaluate_expression',
                'force_crc',
                'get_active_entities_count',
                'get_entity_by_tag',
                'get_filtered_achievement_prototypes',
                'get_filtered_decorative_prototypes',
                'get_filtered_entity_prototypes',
                'get_filtered_equipment_prototypes',
                'get_filtered_fluid_prototypes',
                'get_filtered_item_prototypes',
                'get_filtered_mod_setting_prototypes',
                'get_filtered_recipe_prototypes',
                'get_filtered_technology_prototypes',
                'get_filtered_tile_prototypes',
                'get_map_exchange_string',
                'get_player',
                'get_script_inventories',
                'get_surface',
                'get_train_stops',
                'is_demo',
                'is_multiplayer',
                'is_valid_sound_path',
                'is_valid_sprite_path',
                'json_to_table',
                'kick_player',
                'merge_forces',
                'mute_player',
                'parse_map_exchange_string',
                'play_sound',
                'print',
                'purge_player',
                'regenerate_entity',
                'reload_mods',
                'reload_script',
                'remove_offline_players',
                'remove_path',
                'reset_game_state',
                'reset_time_played',
                'save_atlas',
                'server_save',
                'set_game_state',
                'set_wait_for_screenshots_to_finish',
                'show_message_dialog',
                'table_to_json',
                'take_screenshot',
                'take_technology_screenshot',
                'unban_player',
                'unmute_player',
                'write_file',
                'object_name',
                achievement_prototypes = { other_fields = true },
                active_mods = { other_fields = true },
                ammo_category_prototypes = { other_fields = true },
                autoplace_control_prototypes = { other_fields = true },
                autosave_enabled = { read_only = false },
                backer_names = { other_fields = true },
                connected_players = { other_fields = true },
                custom_input_prototypes = { other_fields = true },
                damage_prototypes = { other_fields = true },
                decorative_prototypes = { other_fields = true },
                default_map_gen_settings = { other_fields = true },
                difficulty = {},
                difficulty_settings = { other_fields = true },
                draw_resource_selection = { read_only = false },
                enemy_has_vision_on_land_mines = { read_only = false },
                entity_prototypes = { other_fields = true },
                equipment_category_prototypes = { other_fields = true },
                equipment_grid_prototypes = { other_fields = true },
                equipment_prototypes = { other_fields = true },
                finished = {},
                finished_but_continuing = {},
                fluid_prototypes = { other_fields = true },
                font_prototypes = { other_fields = true },
                forces = { other_fields = true },
                fuel_category_prototypes = { other_fields = true },
                item_group_prototypes = { other_fields = true },
                item_prototypes = { other_fields = true },
                item_subgroup_prototypes = { other_fields = true },
                map_gen_presets = { other_fields = true },
                map_settings = { other_fields = true },
                max_beacon_supply_area_distance = {},
                max_electric_pole_connection_distance = {},
                max_electric_pole_supply_area_distance = {},
                max_force_distraction_chunk_distance = {},
                max_force_distraction_distance = {},
                max_gate_activation_distance = {},
                max_inserter_reach_distance = {},
                max_pipe_to_ground_distance = {},
                max_underground_belt_distance = {},
                mod_setting_prototypes = { other_fields = true },
                module_category_prototypes = { other_fields = true },
                named_noise_expressions = { other_fields = true },
                noise_layer_prototypes = { other_fields = true }
            }
        }

        LuaBootstrap = {
            fields = {
                'generate_event_name',
                'get_event_filter',
                'get_event_handler',
                'get_event_order',
                'on_configuration_changed',
                'on_event',
                'on_init',
                'on_load',
                'on_nth_tick',
                'raise_biter_base_built',
                'raise_console_chat',
                'raise_event',
                'raise_market_item_purchased',
                'raise_player_crafted_item',
                'raise_player_fast_transferred',
                'raise_script_built',
                'raise_script_destroy',
                'raise_script_revive',
                'raise_script_set_tiles',
                'register_on_entity_destroyed',
                'set_event_filter',
                'object_name',
                active_mods = { other_fields = true },
                level = { fields = { 'campaign_name', 'is_simulation', 'is_tutorial', 'level_name', 'mod_name' } },
                mod_name = {}
            }
        }

        LuaSettings = {
            fields = {
                'get_player_settings',
                startup = { other_fields = true },
                global = { other_fields = true, read_only = false },
                player = { other_fields = true, read_only = false }
            }
        }

        LuaRCON = { fields = { 'print', 'object_name' } }

        LuaRemote = { fields = { 'add_interface', 'call', 'remove_interface', 'object_name', interfaces = { other_fields = true } } }

        LuaCommandProcessor = {
            fields = { 'add_command', 'remove_command', 'object_name', commands = { other_fields = true }, game_commands = { other_fields = true } }
        }

        LuaRendering = {
            fields = {
                'bring_to_front', 'clear', 'destroy', 'draw_animation', 'draw_arc', 'draw_circle', 'draw_light', 'draw_line', 'draw_polygon', 'draw_rectangle',
                'draw_sprite', 'draw_text', 'get_alignment', 'get_all_ids', 'get_angle', 'get_animation', 'get_animation_offset', 'get_animation_speed',
                'get_color', 'get_dash_length', 'get_draw_on_ground', 'get_filled', 'get_font', 'get_forces', 'get_from', 'get_gap_length', 'get_intensity',
                'get_left_top', 'get_max_radius', 'get_min_radius', 'get_minimum_darkness', 'get_only_in_alt_mode', 'get_orientation', 'get_orientation_target',
                'get_oriented', 'get_oriented_offset', 'get_players', 'get_radius', 'get_render_layer', 'get_right_bottom', 'get_scale', 'get_scale_with_zoom',
                'get_sprite', 'get_start_angle', 'get_surface', 'get_target', 'get_text', 'get_time_to_live', 'get_to', 'get_type', 'get_vertical_alignment',
                'get_vertices', 'get_visible', 'get_width', 'get_x_scale', 'get_y_scale', 'is_font_valid', 'is_valid', 'set_alignment', 'set_angle',
                'set_animation', 'set_animation_offset', 'set_animation_speed', 'set_color', 'set_corners', 'set_dash_length', 'set_dashes',
                'set_draw_on_ground', 'set_filled', 'set_font', 'set_forces', 'set_from', 'set_gap_length', 'set_intensity', 'set_left_top', 'set_max_radius',
                'set_min_radius', 'set_minimum_darkness', 'set_only_in_alt_mode', 'set_orientation', 'set_orientation_target', 'set_oriented',
                'set_oriented_offset', 'set_players', 'set_radius', 'set_render_layer', 'set_right_bottom', 'set_scale', 'set_scale_with_zoom', 'set_sprite',
                'set_start_angle', 'set_target', 'set_text', 'set_time_to_live', 'set_to', 'set_vertical_alignment', 'set_vertices', 'set_visible', 'set_width',
                'set_x_scale', 'set_y_scale', 'object_name'
            }
        }
    end

    stds.factorio = {
        -- Set the read only variables
        read_globals = {
            'log',
            'serpent',
            'table_size',
            lldebugger = { fields = { 'requestBreak' }, other_fields = true, read_only = false },
            __DebugAdapter = { fields = { 'print', 'stepIgnoreAll', 'stepIgnore', 'breakpoint' }, other_fields = true, read_only = false },
            __Profiler = { other_fields = true, read_only = false },
            table = { fields = { 'compare', 'deepcopy' } }
        }
    }

    stds.factorio_control = {
        read_globals = {
            commands = LuaCommandProcessor,
            settings = LuaSettings,
            script = LuaBootstrap,
            rcon = LuaRcon,
            rendering = LuaRendering,
            game = LuaGameScript
        },
        globals = { 'global' }
    }

    stds.factorio_data = {
        read_globals = {
            data = { fields = { 'extend', 'is_demo', raw = { other_fields = true, read_only = false } } },
            settings = { fields = { 'startup', 'global', 'player' } },
            mods = { other_fields = true },
            angelsmods = { other_fields = true },
            bobmods = { other_fields = true }
        }
    }
end

do -- Factorio Base and Core mod STDs
    stds.factorio_base_control = {}

    stds.factorio_base_scenarios = {
        globals = {
            'check_automate_science_packs_advice', 'check_research_hints', 'check_supplies', 'manage_attacks', 'all_dead', 'on_win', 'difficulty_number',
            'init_attack_data', 'handle_attacks', 'count_items_in_container', 'progress', 'scanned', 'check_light', 'check_machine_gun', 'level', 'story_table',
            'tightspot_prices', 'tightspot_make_offer', 'tightspot_init', 'tightspot_get_required_balance', 'tightspot_init_level',
            'tightspot_init_spending_frame', 'tightspot_init_progress_frame', 'tightspot_update_progress', 'tightspot_update_spending',
            'tightspot_get_missing_to_win', 'tightspot_sell_back', 'tightspot_start_level', 'tightspot_show_level_description', 'tightspot_update_speed_label',
            'map_ignore', 'tightspot_check_level', 'land_price', 'transport_belt_madness_init', 'transport_belt_madness_init_level',
            'transport_belt_madness_create_chests', 'transport_belt_madness_fill_chests', 'transport_belt_madness_start_level', 'map_ignore', 'map_clear',
            'map_load', 'map_save', 'transport_belt_madness_show_level_description', 'transport_belt_madness_check_level', 'transport_belt_madness_next_level',
            'transport_belt_madness_clear_level', 'transport_belt_madness_contains_next_level', 'restricted', 'check_built_items', 'result',
            'disable_combat_technologies', 'apply_character_modifiers', 'apply_combat_modifiers', 'apply_balance', 'load_config', 'starting_area_constant',
            'create_next_surface', 'end_round', 'prepare_next_round', 'silo_died', 'choose_joining_gui', 'destroy_joining_guis', 'create_random_join_gui',
            'create_auto_assign_gui', 'create_pick_join_gui', 'create_config_gui', 'make_config_table', 'default', 'make_team_gui', 'make_team_gui_config',
            'add_team_button_press', 'trash_team_button_press', 'remove_team_from_team_table', 'add_team_to_team_table', 'set_teams_from_gui',
            'on_team_button_press', 'make_color_dropdown', 'create_balance_option', 'create_disable_frame', 'disable_frame', 'parse_disabled_items',
            'set_balance_settings', 'config_confirm', 'parse_config_from_gui', 'get_color', 'roll_starting_area', 'delete_roll_surfaces', 'auto_assign',
            'destroy_config_for_all', 'prepare_map', 'set_evolution_factor', 'update_players_on_team_count', 'random_join', 'init_player_gui',
            'destroy_player_gui', 'objective_button_press', 'admin_button_press', 'admin_frame_button_press', 'diplomacy_button_press',
            'update_diplomacy_frame', 'diplomacy_frame_button_press', 'team_changed_diplomacy', 'diplomacy_check_press', 'get_stance', 'give_inventory',
            'setup_teams', 'disable_items_for_all', 'set_random_team', 'set_diplomacy', 'create_spawn_positions', 'set_spawn_position',
            'set_team_together_spawns', 'chart_starting_area_for_force_spawns', 'check_starting_area_chunks_are_generated', 'check_player_color',
            'check_round_start', 'clear_starting_area_enemies', 'check_no_rush_end', 'check_no_rush_players', 'finish_setup', 'chart_area_for_force',
            'setup_start_area_copy', 'update_copy_progress', 'update_progress_bar', 'copy_paste_starting_area_tiles', 'copy_paste_starting_area_entities',
            'create_silo_for_force', 'setup_research', 'on_chunk_generated', 'get_distance_to_nearest_spawn', 'create_wall_for_force', 'fpn', 'give_items',
            'create_item_frame', 'create_technologies_frame', 'create_cheat_frame', 'create_day_frame', 'time_modifier', 'points_per_second_start',
            'points_per_second_level_subtract', 'levels', 'update_info', 'get_time_left', 'update_time_left', 'on_joined', 'make_frame', 'update_frame',
            'update_table', 'calculate_task_item_multiplayer', 'setup_config', 'select_from_probability_table', 'select_inventory', 'select_equipment',
            'select_challange_type', 'save_round_statistics', 'start_challenge', 'create_teams', 'set_areas', 'decide_player_team', 'set_teams',
            'refresh_leaderboard', 'set_player', 'generate_technology_list', 'generate_research_task', 'setup_unlocks', 'check_technology_progress',
            'generate_production_task', 'generate_shopping_list_task', 'set_gui_flow_table', 'create_visibility_button', 'check_item_lists', 'update_task_gui',
            'check_end_of_round', 'end_round_gui_update', 'try_to_check_victory', 'update_gui', 'check_start_round', 'check_start_set_areas',
            'check_start_setting_entities', 'check_set_areas', 'check_clear_areas', 'check_chests', 'check_chests_shopping_list', 'check_chests_production',
            'check_input_chests', 'fill_input_chests', 'check_victory', 'shopping_task_finished', 'calculate_force_points', 'update_research_task_table',
            'update_production_task_table', 'update_shopping_list_task_table', 'create_joined_game_gui', 'pre_ending_round', 'player_ending_prompt',
            'update_end_timer', 'update_begin_timer', 'team_finished', 'save_points_list', 'give_force_players_points', 'update_winners_list', 'set_spectator',
            'set_character', 'give_starting_inventory', 'give_equipment', 'shuffle_table', 'format_time', 'spairs', 'fill_leaderboard', 'create_grid',
            'simple_entities', 'save_map_data', 'clear_map', 'create_tiles', 'recreate_entities', 'map_sets', 'give_points', 'init_forces', 'init_globals',
            'init_unit_settings', 'check_next_wave', 'next_wave', 'calculate_wave_power', 'wave_end', 'make_next_spawn_tick', 'check_spawn_units',
            'get_wave_units', 'spawn_units', 'randomize_ore', 'set_command', 'command_straglers', 'unit_config', 'make_next_wave_tick', 'time_to_next_wave',
            'time_to_wave_end', 'rocket_died', 'unit_died', 'get_bounty_price', 'setup_waypoints', 'insert_items', 'give_starting_equipment',
            'give_spawn_equipment', 'next_round_button_visible', 'gui_init', 'create_wave_frame', 'create_money_frame', 'create_upgrade_gui',
            'update_upgrade_listing', 'upgrade_research', 'get_upgrades', 'get_money', 'update_connected_players', 'update_round_number', 'set_research',
            'set_recipes', 'check_deconstruction', 'check_blueprint_placement', 'loop_entities', 'experiment_items', 'setup', 'story_gui_click',
            'clear_surface', 'add_run_trains_button', 'puzzle_condition', 'basic_signals', 'loop_trains', 'Y_offset', 'ghosts_1', 'ghosts_2', 'required_path',
            'through_wall_path', 'count', 'check_built_real_rail', 'current_ghosts_count', 'other', 'rails', 'set_rails', 'straight_section', 'late_entities',
            'entities', 'stop', 'get_spawn_coordinate', -- tutorials
            'intermission', 'create_entities_on_tick', 'on_player_created', 'required_count', 'non_player_entities', 'clear_rails', 'chest', 'damage',
            'furnace', 'init_prototypes', 'build_infi_table', 'junk', 'update_player_tags', 'time_left', 'team_production', 'create_task_frame',
            'create_visibilty_buttons', 'update_leaderboard', 'in_in_area'
        }
    }

    stds.factorio_base_data_common = { globals = { 'circuit_connector_definitions', 'logistic_chest_opened_duration' } }

    stds.factorio_base_data = {
        globals = {

            'make_cursor_box', 'make_full_cursor_box', 'default_container_padding', 'default_orange_color', 'default_light_orange_color', 'warning_red_color',
            'achievement_green_color', 'achievement_tan_color', 'orangebuttongraphcialset', 'bluebuttongraphcialset', 'bonus_gui_ordering', 'trivial_smoke',
            'technology_slot_base_width', 'technology_slot_base_height', 'default_frame_font_vertical_compensation', 'transport_belt_connector_frame_sprites',
            'transport_belt_circuit_wire_connection_point', 'transport_belt_circuit_wire_max_distance', 'transport_belt_circuit_connector_sprites',
            'ending_patch_prototype', 'basic_belt_horizontal', 'basic_belt_vertical', 'basic_belt_ending_top', 'basic_belt_ending_bottom',
            'basic_belt_ending_side', 'basic_belt_starting_top', 'basic_belt_starting_bottom', 'basic_belt_starting_side', 'fast_belt_horizontal',
            'fast_belt_vertical', 'fast_belt_ending_top', 'fast_belt_ending_bottom', 'fast_belt_ending_side', 'fast_belt_starting_top',
            'fast_belt_starting_bottom', 'fast_belt_starting_side', 'express_belt_horizontal', 'express_belt_vertical', 'express_belt_ending_top',
            'express_belt_ending_bottom', 'express_belt_ending_side', 'express_belt_starting_top', 'express_belt_starting_bottom', 'express_belt_starting_side',
            'circuit_connector_definitions', 'default_circuit_wire_max_distance', 'inserter_circuit_wire_max_distance', 'universal_connector_template',
            'belt_connector_template', 'belt_frame_connector_template', 'inserter_connector_template', 'inserter_circuit_wire_max_distance',
            'inserter_default_stack_control_input_signal', 'make_heavy_gunshot_sounds', 'make_light_gunshot_sounds', 'make_laser_sounds',
            'gun_turret_extension', 'gun_turret_extension_shadow', 'gun_turret_extension_mask', 'gun_turret_attack', 'laser_turret_extension',
            'laser_turret_extension_shadow', 'laser_turret_extension_mask', 'pipecoverspictures', 'pipepictures', 'assembler2pipepictures',
            'assembler3pipepictures', 'make_heat_pipe_pictures', 'generate_arithmetic_combinator', 'generate_decider_combinator',
            'generate_constant_combinator', 'destroyed_rail_pictures', 'rail_pictures', 'rail_pictures_internal', 'standard_train_wheels', 'drive_over_tie',
            'rolling_stock_back_light', 'rolling_stock_stand_by_light', 'make_enemy_autoplace', 'make_enemy_spawner_autoplace', 'make_enemy_worm_autoplace',
            'make_spitter_attack_animation', 'make_spitter_run_animation', 'make_spitter_dying_animation', 'make_spitter_attack_parameters',
            'make_spitter_roars', 'make_spitter_dying_sounds', 'make_spawner_idle_animation', 'make_spawner_die_animation', 'make_biter_run_animation',
            'make_biter_attack_animation', 'make_biter_die_animation', 'make_biter_roars', 'make_biter_dying_sounds', 'make_biter_calls', 'make_worm_roars',
            'make_worm_dying_sounds', 'make_worm_folded_animation', 'make_worm_preparing_animation', 'make_worm_prepared_animation',
            'make_worm_attack_animation', 'make_worm_die_animation', 'tile_variations_template', 'make_water_autoplace_settings', 'make_unit_melee_ammo_type',
            'make_trivial_smoke', 'make_4way_animation_from_spritesheet', 'flying_robot_sounds', 'productivitymodulelimitation', 'crash_trigger',
            'capsule_smoke', 'make_beam', 'playeranimations', 'make_blood_tint', 'make_shadow_tint', 'water_transition_template',
            'make_water_transition_template', 'water_autoplace_settings', 'water_tile_type_names', 'patch_for_inner_corner_of_transition_between_transition'
        }
    }

    stds.factorio_base_story = {
        globals = {
            'story_init_helpers', 'story_update_table', 'story_init', 'story_update', 'story_on_tick', 'story_add_update', 'story_remove_update',
            'story_jump_to', 'story_elapsed', 'story_elapsed_check', 'story_show_message_dialog', 'set_goal', 'player_set_goal', 'on_player_joined',
            'flash_goal', 'set_info', 'player_set_info', 'export_entities', 'list', 'recreate_entities', 'entity_to_connect', 'limit_camera',
            'find_gui_recursive', 'enable_entity_export', 'add_button', 'on_gui_click', 'set_continue_button_style', 'add_message_log', 'story_add_message_log',
            'player_add_message_log', 'message_log_frame', 'message_log_scrollpane', 'message_log_close_button', 'message_log_table',
            'toggle_message_log_button', 'toggle_objective_button', 'message_log_init', 'add_gui_recursive', 'add_toggle_message_log_button',
            'add_toggle_objective_button', 'mod_gui', 'flash_message_log_button', 'flash_message_log_on_tick', 'story_gui_click', 'story_points_by_name',
            'story_branches', 'player', 'surface', 'deconstruct_on_tick', 'recreate_entities_on_tick', 'flying_congrats', 'story_table'
        }
    }

    stds.factorio_circuit_connector_generated = {
        globals = {
            'default_circuit_wire_max_distance', 'circuit_connector_definitions', 'universal_connector_template', 'belt_connector_template',
            'belt_frame_connector_template', 'inserter_connector_template', 'inserter_connector_template', 'inserter_circuit_wire_max_distance',
            'inserter_default_stack_control_input_signal', 'transport_belt_connector_frame_sprites', 'transport_belt_circuit_wire_max_distance'
        }
    }
end

do -- STDLIB
    stds.stdlib = {
        read_globals = {},
        globals = {
            'STDLIB', 'prequire', 'rawtostring', 'traceback', 'data_traceback', 'inspect', 'serpent', 'inline_if', 'install', 'log', 'concat', 'GAME', 'AREA',
            'POSITION', 'TILE', 'SURFACE', 'CHUNK', 'COLOR', 'ENTITY', 'INVENTORY', 'RESOURCE', 'CONFIG', 'LOGGER', 'QUEUE', 'EVENT', 'GUI', 'PLAYER', 'FORCE',
            'MATH', 'STRING', 'TABLE'
        }
    }

    stds.stdlib_control = {}

    stds.stdlib_data = { globals = { 'DATA', 'RECIPE', 'ITEM', 'FLUID', 'ENTITY', 'TECHNOLOGY', 'CATEGORY' } }

    stds.stdlib_love = {
        read_globals = {
            love = { fields = { arg = { fields = { 'parseGameArguments', 'parseOption', 'getLow', 'optionIndices', 'options' } } } },
            'coroutine',
            'io',
            'socket',
            'dofile',
            'loadfile'
        },
        globals = { love = { fields = { 'handlers' } } }
    }
end

stds.factorio_defines = {
    __VERSION = '1.1.53',
    read_globals = {
        defines = {
            fields = {
                alert_type = {
                    fields = {
                        'custom', 'entity_destroyed', 'entity_under_attack', 'no_material_for_construction', 'no_storage', 'not_enough_construction_robots',
                        'not_enough_repair_packs', 'train_out_of_fuel', 'turret_fire'
                    }
                },
                anticolor = { other_fields = true },
                behavior_result = { fields = { 'deleted', 'fail', 'in_progress', 'success' } },
                build_check_type = { fields = { 'blueprint_ghost', 'ghost_revive', 'manual', 'manual_ghost', 'script', 'script_ghost' } },
                chain_signal_state = { fields = { 'all_open', 'none', 'none_open', 'partially_open' } },
                chunk_generated_status = { fields = { 'basic_tiles', 'corrected_tiles', 'custom_tiles', 'entities', 'nothing', 'tiles' } },
                circuit_condition_index = {
                    fields = {
                        'arithmetic_combinator', 'constant_combinator', 'decider_combinator', 'inserter_circuit', 'inserter_logistic', 'lamp', 'offshore_pump',
                        'pump'
                    }
                },
                circuit_connector_id = {
                    fields = {
                        'accumulator', 'combinator_input', 'combinator_output', 'constant_combinator', 'container', 'electric_pole', 'inserter', 'lamp',
                        'offshore_pump', 'programmable_speaker', 'pump', 'rail_chain_signal', 'rail_signal', 'roboport', 'storage_tank', 'wall'
                    }
                },
                color = { other_fields = true },
                command = { fields = { 'attack', 'attack_area', 'build_base', 'compound', 'flee', 'go_to_location', 'group', 'stop', 'wander' } },
                compound_command = { fields = { 'logical_and', 'logical_or', 'return_last' } },
                control_behavior = {
                    fields = {
                        inserter = {
                            fields = {
                                circuit_mode_of_operation = { fields = { 'enable_disable', 'none', 'read_hand_contents', 'set_filters', 'set_stack_size' } },
                                hand_read_mode = { fields = { 'hold', 'pulse' } }
                            }
                        },
                        lamp = { fields = { circuit_mode_of_operation = { fields = { 'use_colors' } } } },
                        logistic_container = { fields = { circuit_mode_of_operation = { fields = { 'send_contents', 'set_requests' } } } },
                        mining_drill = { fields = { resource_read_mode = { fields = { 'entire_patch', 'this_miner' } } } },
                        transport_belt = { fields = { content_read_mode = { fields = { 'hold', 'pulse' } } } },
                        type = {
                            fields = {
                                'accumulator', 'arithmetic_combinator', 'constant_combinator', 'container', 'decider_combinator', 'generic_on_off', 'inserter',
                                'lamp', 'logistic_container', 'mining_drill', 'programmable_speaker', 'rail_chain_signal', 'rail_signal', 'roboport',
                                'storage_tank', 'train_stop', 'transport_belt', 'wall'
                            }
                        }
                    }
                },
                controllers = { fields = { 'character', 'cutscene', 'editor', 'ghost', 'god', 'spectator' } },
                deconstruction_item = {
                    fields = {
                        entity_filter_mode = { fields = { 'blacklist', 'whitelist' } },
                        tile_filter_mode = { fields = { 'blacklist', 'whitelist' } },
                        tile_selection_mode = { fields = { 'always', 'never', 'normal', 'only' } }
                    }
                },
                difficulty = { fields = { 'easy', 'hard', 'normal' } },
                difficulty_settings = {
                    fields = { recipe_difficulty = { fields = { 'expensive', 'normal' } }, technology_difficulty = { fields = { 'expensive', 'normal' } } }
                },
                direction = { fields = { 'east', 'north', 'northeast', 'northwest', 'south', 'southeast', 'southwest', 'west' } },
                disconnect_reason = {
                    fields = {
                        'afk', 'banned', 'cannot_keep_up', 'desync_limit_reached', 'dropped', 'kicked', 'kicked_and_deleted', 'quit', 'reconnect',
                        'switching_servers', 'wrong_input'
                    }
                },
                distraction = { fields = { 'by_anything', 'by_damage', 'by_enemy', 'none' } },
                entity_status = {
                    fields = {
                        'cant_divide_segments', 'charging', 'closed_by_circuit_network', 'disabled', 'disabled_by_control_behavior', 'disabled_by_script',
                        'discharging', 'fluid_ingredient_shortage', 'full_output', 'fully_charged', 'item_ingredient_shortage', 'launching_rocket',
                        'low_input_fluid', 'low_power', 'low_temperature', 'marked_for_deconstruction', 'missing_required_fluid', 'missing_science_packs',
                        'networks_connected', 'networks_disconnected', 'no_ammo', 'no_fuel', 'no_ingredients', 'no_input_fluid', 'no_minable_resources',
                        'no_modules_to_transmit', 'no_power', 'no_recipe', 'no_research_in_progress', 'normal', 'not_connected_to_rail',
                        'not_plugged_in_electric_network', 'opened_by_circuit_network', 'out_of_logistic_network', 'preparing_rocket_for_launch',
                        'recharging_after_power_outage', 'turned_off_during_daytime', 'waiting_for_source_items', 'waiting_for_space_in_destination',
                        'waiting_for_target_to_be_built', 'waiting_for_train', 'waiting_to_launch_rocket', 'working'
                    }
                },
                events = {
                    fields = {
                        'on_ai_command_completed', 'on_area_cloned', 'on_biter_base_built', 'on_brush_cloned', 'on_build_base_arrived', 'on_built_entity',
                        'on_cancelled_deconstruction', 'on_cancelled_upgrade', 'on_character_corpse_expired', 'on_chart_tag_added', 'on_chart_tag_modified',
                        'on_chart_tag_removed', 'on_chunk_charted', 'on_chunk_deleted', 'on_chunk_generated', 'on_combat_robot_expired', 'on_console_chat',
                        'on_console_command', 'on_cutscene_cancelled', 'on_cutscene_waypoint_reached', 'on_difficulty_settings_changed', 'on_entity_cloned',
                        'on_entity_damaged', 'on_entity_destroyed', 'on_entity_died', 'on_entity_logistic_slot_changed', 'on_entity_renamed',
                        'on_entity_settings_pasted', 'on_entity_spawned', 'on_equipment_inserted', 'on_equipment_removed', 'on_force_cease_fire_changed',
                        'on_force_created', 'on_force_friends_changed', 'on_force_reset', 'on_forces_merged', 'on_forces_merging',
                        'on_game_created_from_scenario', 'on_gui_checked_state_changed', 'on_gui_click', 'on_gui_closed', 'on_gui_confirmed',
                        'on_gui_elem_changed', 'on_gui_location_changed', 'on_gui_opened', 'on_gui_selected_tab_changed', 'on_gui_selection_state_changed',
                        'on_gui_switch_state_changed', 'on_gui_text_changed', 'on_gui_value_changed', 'on_land_mine_armed', 'on_lua_shortcut',
                        'on_marked_for_deconstruction', 'on_marked_for_upgrade', 'on_market_item_purchased', 'on_mod_item_opened', 'on_permission_group_added',
                        'on_permission_group_deleted', 'on_permission_group_edited', 'on_permission_string_imported', 'on_picked_up_item',
                        'on_player_alt_selected_area', 'on_player_ammo_inventory_changed', 'on_player_armor_inventory_changed', 'on_player_banned',
                        'on_player_built_tile', 'on_player_cancelled_crafting', 'on_player_changed_force', 'on_player_changed_position',
                        'on_player_changed_surface', 'on_player_cheat_mode_disabled', 'on_player_cheat_mode_enabled', 'on_player_clicked_gps_tag',
                        'on_player_configured_blueprint', 'on_player_configured_spider_remote', 'on_player_crafted_item', 'on_player_created',
                        'on_player_cursor_stack_changed', 'on_player_deconstructed_area', 'on_player_demoted', 'on_player_died',
                        'on_player_display_resolution_changed', 'on_player_display_scale_changed', 'on_player_driving_changed_state', 'on_player_dropped_item',
                        'on_player_fast_transferred', 'on_player_flushed_fluid', 'on_player_gun_inventory_changed', 'on_player_joined_game', 'on_player_kicked',
                        'on_player_left_game', 'on_player_main_inventory_changed', 'on_player_mined_entity', 'on_player_mined_item', 'on_player_mined_tile',
                        'on_player_muted', 'on_player_pipette', 'on_player_placed_equipment', 'on_player_promoted', 'on_player_removed',
                        'on_player_removed_equipment', 'on_player_repaired_entity', 'on_player_respawned', 'on_player_rotated_entity',
                        'on_player_selected_area', 'on_player_set_quick_bar_slot', 'on_player_setup_blueprint', 'on_player_toggled_alt_mode',
                        'on_player_toggled_map_editor', 'on_player_trash_inventory_changed', 'on_player_unbanned', 'on_player_unmuted',
                        'on_player_used_capsule', 'on_player_used_spider_remote', 'on_post_entity_died', 'on_pre_build', 'on_pre_chunk_deleted',
                        'on_pre_entity_settings_pasted', 'on_pre_ghost_deconstructed', 'on_pre_permission_group_deleted', 'on_pre_permission_string_imported',
                        'on_pre_player_crafted_item', 'on_pre_player_died', 'on_pre_player_left_game', 'on_pre_player_mined_item', 'on_pre_player_removed',
                        'on_pre_player_toggled_map_editor', 'on_pre_robot_exploded_cliff', 'on_pre_script_inventory_resized', 'on_pre_surface_cleared',
                        'on_pre_surface_deleted', 'on_research_finished', 'on_research_reversed', 'on_research_started', 'on_resource_depleted',
                        'on_robot_built_entity', 'on_robot_built_tile', 'on_robot_exploded_cliff', 'on_robot_mined', 'on_robot_mined_entity',
                        'on_robot_mined_tile', 'on_robot_pre_mined', 'on_rocket_launch_ordered', 'on_rocket_launched', 'on_runtime_mod_setting_changed',
                        'on_script_inventory_resized', 'on_script_path_request_finished', 'on_script_trigger_effect', 'on_sector_scanned',
                        'on_selected_entity_changed', 'on_spider_command_completed', 'on_string_translated', 'on_surface_cleared', 'on_surface_created',
                        'on_surface_deleted', 'on_surface_imported', 'on_surface_renamed', 'on_technology_effects_reset', 'on_tick', 'on_train_changed_state',
                        'on_train_created', 'on_train_schedule_changed', 'on_trigger_created_entity', 'on_trigger_fired_artillery', 'on_unit_added_to_group',
                        'on_unit_group_created', 'on_unit_group_finished_gathering', 'on_unit_removed_from_group', 'on_worker_robot_expired',
                        'script_raised_built', 'script_raised_destroy', 'script_raised_revive', 'script_raised_set_tiles'
                    }
                },
                flow_precision_index = {
                    fields = {
                        'fifty_hours', 'five_seconds', 'one_hour', 'one_minute', 'one_thousand_hours', 'ten_hours', 'ten_minutes', 'two_hundred_fifty_hours'
                    }
                },
                group_state = { fields = { 'attacking_distraction', 'attacking_target', 'finished', 'gathering', 'moving', 'pathfinding', 'wander_in_group' } },
                gui_type = {
                    fields = {
                        'achievement', 'blueprint_library', 'bonus', 'controller', 'custom', 'entity', 'equipment', 'item', 'logistic', 'none', 'other_player',
                        'permissions', 'player_management', 'production', 'research', 'server_management', 'tile', 'trains', 'tutorials'
                    }
                },
                input_action = {
                    fields = {
                        'activate_copy', 'activate_cut', 'activate_paste', 'add_permission_group', 'add_train_station', 'admin_action', 'alt_select_area',
                        'alt_select_blueprint_entities', 'alternative_copy', 'begin_mining', 'begin_mining_terrain', 'build', 'build_rail', 'build_terrain',
                        'cancel_craft', 'cancel_deconstruct', 'cancel_new_blueprint', 'cancel_research', 'cancel_upgrade', 'change_active_character_tab',
                        'change_active_item_group_for_crafting', 'change_active_item_group_for_filters', 'change_active_quick_bar',
                        'change_arithmetic_combinator_parameters', 'change_decider_combinator_parameters', 'change_entity_label', 'change_item_description',
                        'change_item_label', 'change_multiplayer_config', 'change_picking_state', 'change_programmable_speaker_alert_parameters',
                        'change_programmable_speaker_circuit_parameters', 'change_programmable_speaker_parameters', 'change_riding_state',
                        'change_shooting_state', 'change_train_stop_station', 'change_train_wait_condition', 'change_train_wait_condition_data', 'clear_cursor',
                        'connect_rolling_stock', 'copy', 'copy_entity_settings', 'copy_opened_blueprint', 'copy_opened_item', 'craft', 'cursor_split',
                        'cursor_transfer', 'custom_input', 'cycle_blueprint_book_backwards', 'cycle_blueprint_book_forwards', 'deconstruct',
                        'delete_blueprint_library', 'delete_blueprint_record', 'delete_custom_tag', 'delete_permission_group', 'destroy_item',
                        'destroy_opened_item', 'disconnect_rolling_stock', 'drag_train_schedule', 'drag_train_wait_condition', 'drop_blueprint_record',
                        'drop_item', 'edit_blueprint_tool_preview', 'edit_custom_tag', 'edit_permission_group', 'export_blueprint', 'fast_entity_split',
                        'fast_entity_transfer', 'flush_opened_entity_fluid', 'flush_opened_entity_specific_fluid', 'go_to_train_station',
                        'grab_blueprint_record', 'gui_checked_state_changed', 'gui_click', 'gui_confirmed', 'gui_elem_changed', 'gui_location_changed',
                        'gui_selected_tab_changed', 'gui_selection_state_changed', 'gui_switch_state_changed', 'gui_text_changed', 'gui_value_changed',
                        'import_blueprint', 'import_blueprint_string', 'import_blueprints_filtered', 'import_permissions_string', 'inventory_split',
                        'inventory_transfer', 'launch_rocket', 'lua_shortcut', 'map_editor_action', 'market_offer', 'mod_settings_changed',
                        'open_achievements_gui', 'open_blueprint_library_gui', 'open_blueprint_record', 'open_bonus_gui', 'open_character_gui',
                        'open_current_vehicle_gui', 'open_equipment', 'open_gui', 'open_item', 'open_logistic_gui', 'open_mod_item',
                        'open_parent_of_opened_item', 'open_production_gui', 'open_technology_gui', 'open_tips_and_tricks_gui', 'open_train_gui',
                        'open_train_station_gui', 'open_trains_gui', 'paste_entity_settings', 'place_equipment', 'quick_bar_pick_slot',
                        'quick_bar_set_selected_page', 'quick_bar_set_slot', 'reassign_blueprint', 'remove_cables', 'remove_train_station',
                        'reset_assembling_machine', 'reset_item', 'rotate_entity', 'select_area', 'select_blueprint_entities', 'select_entity_slot',
                        'select_item', 'select_mapper_slot', 'select_next_valid_gun', 'select_tile_slot', 'send_spidertron', 'set_auto_launch_rocket',
                        'set_autosort_inventory', 'set_behavior_mode', 'set_car_weapons_control', 'set_circuit_condition', 'set_circuit_mode_of_operation',
                        'set_controller_logistic_trash_filter_item', 'set_deconstruction_item_tile_selection_mode',
                        'set_deconstruction_item_trees_and_rocks_only', 'set_entity_color', 'set_entity_energy_property',
                        'set_entity_logistic_trash_filter_item', 'set_filter', 'set_flat_controller_gui', 'set_heat_interface_mode',
                        'set_heat_interface_temperature', 'set_infinity_container_filter_item', 'set_infinity_container_remove_unfiltered_items',
                        'set_infinity_pipe_filter', 'set_inserter_max_stack_size', 'set_inventory_bar', 'set_linked_container_link_i_d',
                        'set_logistic_filter_item', 'set_logistic_filter_signal', 'set_player_color', 'set_recipe_notifications', 'set_request_from_buffers',
                        'set_research_finished_stops_game', 'set_signal', 'set_splitter_priority', 'set_train_stopped', 'set_trains_limit',
                        'set_vehicle_automatic_targeting_parameters', 'setup_assembling_machine', 'setup_blueprint', 'setup_single_blueprint_record',
                        'smart_pipette', 'spawn_item', 'stack_split', 'stack_transfer', 'start_repair', 'start_research', 'start_walking',
                        'stop_building_by_moving', 'switch_connect_to_logistic_network', 'switch_constant_combinator_state',
                        'switch_inserter_filter_mode_state', 'switch_power_switch_state', 'switch_to_rename_stop_gui', 'take_equipment',
                        'toggle_deconstruction_item_entity_filter_mode', 'toggle_deconstruction_item_tile_filter_mode', 'toggle_driving',
                        'toggle_enable_vehicle_logistics_while_moving', 'toggle_entity_logistic_requests', 'toggle_equipment_movement_bonus',
                        'toggle_map_editor', 'toggle_personal_logistic_requests', 'toggle_personal_roboport', 'toggle_show_entity_info', 'translate_string',
                        'undo', 'upgrade', 'upgrade_opened_blueprint_by_item', 'upgrade_opened_blueprint_by_record', 'use_artillery_remote', 'use_item',
                        'wire_dragging', 'write_to_console'
                    }
                },
                inventory = {
                    fields = {
                        'artillery_turret_ammo', 'artillery_wagon_ammo', 'assembling_machine_input', 'assembling_machine_modules', 'assembling_machine_output',
                        'beacon_modules', 'burnt_result', 'car_ammo', 'car_trunk', 'cargo_wagon', 'character_ammo', 'character_armor', 'character_corpse',
                        'character_guns', 'character_main', 'character_trash', 'character_vehicle', 'chest', 'editor_ammo', 'editor_armor', 'editor_guns',
                        'editor_main', 'fuel', 'furnace_modules', 'furnace_result', 'furnace_source', 'god_main', 'item_main', 'lab_input', 'lab_modules',
                        'mining_drill_modules', 'roboport_material', 'roboport_robot', 'robot_cargo', 'robot_repair', 'rocket', 'rocket_silo_result',
                        'rocket_silo_rocket', 'spider_ammo', 'spider_trash', 'spider_trunk', 'turret_ammo'
                    }
                },
                lightcolor = { other_fields = true },
                logistic_member_index = {
                    fields = {
                        'character_provider', 'character_requester', 'character_storage', 'generic_on_off_behavior', 'logistic_container', 'vehicle_storage'
                    }
                },
                logistic_mode = { fields = { 'active_provider', 'buffer', 'none', 'passive_provider', 'requester', 'storage' } },
                mouse_button_type = { fields = { 'left', 'middle', 'none', 'right' } },
                prototypes = { other_fields = true },
                rail_connection_direction = { fields = { 'left', 'none', 'right', 'straight' } },
                rail_direction = { fields = { 'back', 'front' } },
                relative_gui_position = { fields = { 'bottom', 'left', 'right', 'top' } },
                relative_gui_type = {
                    fields = {
                        'accumulator_gui', 'achievement_gui', 'additional_entity_info_gui', 'admin_gui', 'arithmetic_combinator_gui', 'armor_gui',
                        'assembling_machine_gui', 'assembling_machine_select_recipe_gui', 'beacon_gui', 'blueprint_book_gui', 'blueprint_library_gui',
                        'blueprint_setup_gui', 'bonus_gui', 'burner_equipment_gui', 'car_gui', 'constant_combinator_gui', 'container_gui', 'controller_gui',
                        'decider_combinator_gui', 'deconstruction_item_gui', 'electric_energy_interface_gui', 'electric_network_gui', 'entity_variations_gui',
                        'entity_with_energy_source_gui', 'equipment_grid_gui', 'furnace_gui', 'generic_on_off_entity_gui', 'heat_interface_gui',
                        'infinity_pipe_gui', 'inserter_gui', 'item_with_inventory_gui', 'lab_gui', 'lamp_gui', 'linked_container_gui', 'loader_gui',
                        'logistic_gui', 'market_gui', 'mining_drill_gui', 'other_player_gui', 'permissions_gui', 'pipe_gui', 'power_switch_gui',
                        'production_gui', 'programmable_speaker_gui', 'rail_chain_signal_gui', 'rail_signal_gui', 'reactor_gui', 'rename_stop_gui',
                        'resource_entity_gui', 'roboport_gui', 'rocket_silo_gui', 'server_config_gui', 'spider_vehicle_gui', 'splitter_gui',
                        'standalone_character_gui', 'storage_tank_gui', 'tile_variations_gui', 'train_gui', 'train_stop_gui', 'trains_gui',
                        'transport_belt_gui', 'upgrade_item_gui', 'wall_gui'
                    }
                },
                render_mode = { fields = { 'chart', 'chart_zoomed_in', 'game' } },
                rich_text_setting = { fields = { 'disabled', 'enabled', 'highlight' } },
                riding = {
                    fields = {
                        acceleration = { fields = { 'accelerating', 'braking', 'nothing', 'reversing' } },
                        direction = { fields = { 'left', 'right', 'straight' } }
                    }
                },
                shooting = { fields = { 'not_shooting', 'shooting_enemies', 'shooting_selected' } },
                signal_state = { fields = { 'closed', 'open', 'reserved', 'reserved_by_circuit_network' } },
                time = { 'second', 'minute', 'day', 'week', 'month', 'year' },
                train_state = {
                    fields = {
                        'arrive_signal', 'arrive_station', 'destination_full', 'manual_control', 'manual_control_stop', 'no_path', 'no_schedule', 'on_the_path',
                        'path_lost', 'wait_signal', 'wait_station'
                    }
                },
                transport_line = {
                    fields = {
                        'left_line', 'left_split_line', 'left_underground_line', 'right_line', 'right_split_line', 'right_underground_line',
                        'secondary_left_line', 'secondary_left_split_line', 'secondary_right_line', 'secondary_right_split_line'
                    }
                },
                wire_connection_id = { fields = { 'electric_pole', 'power_switch_left', 'power_switch_right' } },
                wire_type = { fields = { 'copper', 'green', 'red' } }
            }
        }
    }
}
