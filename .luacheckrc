-------------------------------------------------------------------------------
--[[LICENSE]]--
-------------------------------------------------------------------------------
-- .luacheckrc
-- This file is free and unencumbered software released into the public domain.
--
-- Anyone is free to copy, modify, publish, use, compile, sell, or
-- distribute this file, either in source code form or as a compiled
-- binary, for any purpose, commercial or non-commercial, and by any
-- means.
--
-- In jurisdictions that recognize copyright laws, the author or authors
-- of this file dedicate any and all copyright interest in the
-- software to the public domain. We make this dedication for the benefit
-- of the public at large and to the detriment of our heirs and
-- successors. We intend this dedication to be an overt act of
-- relinquishment in perpetuity of all present and future rights to this
-- software under copyright law.
--
-- THE FILE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
-- EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-- MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
-- IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
-- OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
-- ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
-- OTHER DEALINGS IN THE SOFTWARE.
--
-- For more information, please refer to <http://unlicense.org/>
--]]

-------------------------------------------------------------------------------
--[[.luacheckrc]]-- Current Factorio Version .16
-------------------------------------------------------------------------------
-- Set up the the standards for this file.
files['.luacheckrc'] = {
    std = "lua52c",
    globals = {"files", "exclude_files", "not_globals", "stds", "std", "max_line_length"},
    max_line_length = false, --turn of line length warnings for this file
}

-------------------------------------------------------------------------------
--[[Set Defaults]]--
-------------------------------------------------------------------------------
local LINE_LENGTH = false -- It is 2017 limits on length are a waste
local IGNORE = {"21./%w+_$", "213/[ijk]", "213/index"}
local NOT_GLOBALS = {"coroutine", "io", "socket", "dofile", "loadfile"} -- These globals are not available to the factorio API

local STD_CONTROL = "lua52c+factorio+factorio_control+stdlib+stdlib_control+factorio_defines"
local STD_DATA = "lua52c+factorio+factorio_data+stdlib+factorio_defines"

-- In a perfect world these would be STD_DATA and STD_CONTROL (mostly)
local STD_BASE_DATA = "lua52c+factorio+factorio_data+factorio_defines+factorio_base_data"
local STD_BASE_CONTROL = "lua52c+factorio+factorio_control+factorio_defines+factorio_base_control"

-------------------------------------------------------------------------------
--[[Assume Factorio Control stage as default]]--
-------------------------------------------------------------------------------
std = STD_CONTROL
max_line_length = LINE_LENGTH

not_globals = NOT_GLOBALS
ignore = IGNORE

--List of files and directories to exclude
exclude_files = {
    "**/.*", --Ignore if path starts with .
    "**/mod/stdlib/", --Ignore from symlinked
    "**/build/",
    "**/deprecated/",

    "**/combat-tester/",
    "**/test-maker/",
    "**/trailer/",
}

-------------------------------------------------------------------------------
--[[Mod Prototypes]]--
-------------------------------------------------------------------------------
--Set default prototype files
files['**/data.lua'].std = STD_DATA
files['**/data-updates.lua'].std = STD_DATA
files['**/data-final-fixes.lua'].std = STD_DATA
files['**/settings.lua'].std = STD_DATA
files['**/settings-updates.lua'].std = STD_DATA
files['**/settings-final-fixes.lua'].std = STD_DATA
files['**/prototypes/'].std = STD_DATA
files['**/settings/'].std = STD_DATA

-------------------------------------------------------------------------------
--[[Base]]--
-------------------------------------------------------------------------------
--Find and replace ignores *.cfg, migrations, *.txt, control.lua, *.json, trailer, scenarios, campaigns, *.glsl

local base_scenarios = {
    std = STD_BASE_CONTROL.."+factorio_base_scenarios+factorio_base_story",
    ignore = {"212/event"}
}
files["**/base/scenarios/"] = base_scenarios
files["**/base/tutorials/"] = base_scenarios
files["**/base/campaigns/"] = base_scenarios

files['**/base/migrations/'] = {std = STD_BASE_CONTROL}

files['**/core/lualib/'] = {std = STD_BASE_CONTROL}
files['**/core/lualib/util.lua'] = {globals = {"util", "table"}, ignore = {"432/object"}}
files['**/core/lualib/silo-script.lua'] = {globals = {"silo_script"}, ignore = {"4../player"}}
files['**/core/lualib/story.lua'] = {std = "+factorio_base_story", ignore = {"42./k", "42./filter"}}
files['**/core/lualib/mod-gui.lua'] = {globals = {"mod_gui"}}
files['**/core/lualib/dataloader.lua'] = {globals = {"data"}}
files['**/core/lualib/camera.lua'] = {globals = {"camera"}}
files['**/core/lualib/builder.lua'] = {globals = {"Builder", "builder", "action", "down", "right"}}

files['**/base/prototypes/'] = {std = STD_BASE_DATA}
files['**/core/prototypes/'] = {std = STD_BASE_DATA}

-------------------------------------------------------------------------------
--[[Set STDLIB project modules]]--
-------------------------------------------------------------------------------
local stdlib_control = {
    std = "lua52c+factorio+factorio_control+stdlib+stdlib_control+factorio_defines",
    max_line_length = LINE_LENGTH,
}

local stdlib_data = {
    std = "lua52c+factorio+factorio_data+stdlib+factorio_defines",
    max_line_length = LINE_LENGTH,
}

-- Assume control stage for stdlib
files["**/stdlib/"] = stdlib_control

-- STDLIB global mutates
files["**/stdlib/string.lua"] = {std = "lua52c", globals = {"string"}} --DEPRECATED
files["**/stdlib/table.lua"] = {std = "lua52c", globals = {"table"}, ignore = {"table_size"}} --DEPRECATED

files["**/stdlib/utils/math.lua"].std = "lua52c"
files["**/stdlib/utils/string.lua"].std = "lua52c"
files["**/stdlib/utils/table.lua"].std = "lua52c"
files["**/stdlib/utils/iterator.lua"].std = "lua52c"

-- STDLIB data files
files["**/stdlib/data/"] = stdlib_data
files["**/stdlib/prototype"] = stdlib_data --DEPRECATED
files["**/creative"].ignore = {"..."}

-- STDLIB Busted Spec
files['**/spec/**'] = {
    globals = {"Event", "Gui", "Config", "Logger", "Core", "serpent", "log", "SLOG", "RESET"},
    std = "lua52c+busted+factorio_defines+factorio_control+stdlib_control+stdlib",
}

-------------------------------------------------------------------------------
--[[STDS FACTORIO]]--
-------------------------------------------------------------------------------
stds.factorio = {
    --Set the read only variables
    read_globals = {
        -- @log@: Gives writing access to Factorio's logger instance.
        "log",
        -- @serpent@: Lua serializer and pretty printer. (https://github.com/pkulchenko/serpent)
        "serpent",
        -- @table_size@: Returns the number of elements inside an LUA table
        "table_size",
        util = {
            fields = {
                "by_pixel", "distance", "findfirstentity", "positiontostr", "formattime", "moveposition", "oppositedirection",
                "ismoduleavailable", "multiplystripes", "format_number", "increment", "color", "make_color", "conditional_return",
                table = {
                    fields = {
                        "compare", "deepcopy"
                    },
                },
            },
        },
        table = {
            fields = {
                "compare", "deepcopy"
            },
        },
    },
}

stds.factorio_control = {
    read_globals = {

        -- @commands@:
        commands = {
            fields = {
                "add_command", "commands", "game_commands",
            },
        },

        -- @settings@:
        settings = {
            fields = {
                "get_player_settings", "startup", "global", "player",
            },
        },

        -- @script@: Provides an interface for registering event handlers.
        -- (http://lua-api.factorio.com/latest/LuaBootstrap.html)
        script = {
            fields = {
                "on_event", "on_configuration_changed", "on_init", "on_load", "generate_event_name",
                "raise_event", "get_event_handler", "mod_name",
            },
        },

        -- @remote@: Allows inter-mod communication by providing a repository of interfaces that is shared by all mods.
        -- (http://lua-api.factorio.com/latest/LuaRemote.html)
        remote = {
            fields = {
                "add_interface", "remove_interface", "call", "interfaces"
            },
        },

        -- @game@: Main object through which most of the API is accessed.
        -- It is, however, not available inside handlers registered with @script.on_load@.
        -- (http://lua-api.factorio.com/latest/LuaGameScript.html)
        game ={
            other_fields = true,
            read_only = false,
            fields = {
                "set_game_state", "get_entity_by_tag", "show_message_dialog", "disable_tips_and_tricks", "is_demo", "reload_script",
                "save_atlas", "check_consistency", "regenerate_entity", "take_screenshot", "write_file", "remove_path",
                "remove_offline_players", "force_crc", "merge_forces", "player", "server_save", "delete_surface", "disable_replay",
                "direction_to_string", "print", "tick", "finished", "difficulty",
                speed = {
                    --rw
                    read_only = false,
                },
                player = {
                    --luaPlayer
                    --The player typing at the console, nil in all other cases
                    read_only = false,
                    other_fields = true,
                },
                players = {
                    --array of luaPlayer
                    read_only = false,
                    other_fields = true,
                },
                connected_players = {
                    --array of luaPlayer
                    read_only = false,
                    other_fields = true,
                },
                surfaces = {
                    --array of luaSurface
                    read_only = false,
                    other_fields = true,
                },
                create_surface = {
                    --luaSurface
                    read_only = false,
                    other_fields = true,
                },
                forces = {
                    --array of luaForce
                    read_only = false,
                    other_fields = true,
                },
                create_force = {
                    --luaForce
                    read_only = false,
                    other_fields = true,
                },
                entity_prototypes = {
                    --string dictionary - > luaEntityPrototype
                    read_only = true,
                    other_fields = true
                },
                item_prototypes = {
                    --string dictionary - > luaItemPrototype
                    read_only = true,
                    other_fields = true
                },
                fluid_prototypes = {
                    --string dictionary - > luaFluidPrototype
                    read_only = true,
                    other_fields = true
                },
                tile_prototypes = {
                    --string dictionary - > luaTilePrototype
                    read_only = true,
                    other_fields = true
                },
                equipment_prototypes = {
                    --string dictionary - > luaEquipmentPrototype
                    read_only = true,
                    other_fields = true
                },
                recipe_prototypes = {
                    --string dictionary - > luaRecipePrototype
                    read_only = true,
                    other_fields = true
                },
                technology_prototypes = {
                    --string dictionary - > luaTechnologyPrototype
                    read_only = true,
                    other_fields = true
                },
                damage_prototypes = {
                    --string dictionary - > luaDamagePrototype
                    read_only = true,
                    other_fields = true
                },
                virtual_signal_prototypes = {
                    --string dictionary - > luaVirtualSignalPrototype
                    read_only = true,
                    other_fields = true
                },
                equipment_grid_prototypes = {
                    --string dictionary - > luaEquipmentGridPrototype
                    read_only = true,
                    other_fields = true
                },
                decorative_prototypes = {
                    --string dictionary -> LuaDecorativePrototype
                    read_only = true,
                    other_fields = true
                },
                map_settings = {
                    --custom -> mapsettings
                    read_only = false,
                    other_fields = true
                },
                active_mods = {
                    --string dictionary -> string version
                    read_only = true,
                    other_fields = true
                },
                permissions = {
                    read_only = true,
                    other_fields = true
                },
            },
        },
    },

    globals = {
        -- @global@: The global dictionary, useful for storing data persistent across a save-load cycle.
        -- Writing access is given to the mod-id field (for mod-wise saved data).
        -- (http://lua-api.factorio.com/latest/Global.html)
        "global",

        -- @MOD@: Keep it organized, use this variable for anything that "NEEDS" to be global for some reason.
        "MOD"
    },
}

stds.factorio_data = {

    read_globals = {
        data = {
            fields = {
                raw = {
                    other_fields = true,
                    read_only = false
                },
                "extend", "is_demo"
            },
        },

        settings = {
            fields = {
                "startup", "global", "player",
            },
        },

        --Popular mods
        angelsmods = {
            other_fields = true
        },

        bobmods = {
            other_fields = true
        },

        mods = {
            other_fields = true
        }
    }
}

stds.factorio_base_control = {
    read_globals = {"silo_script", "mod_gui", "camera"}
}

stds.factorio_base_scenarios = {
    globals = {
        "check_automate_science_packs_advice", "check_research_hints", "check_supplies", "manage_attacks", "all_dead",
        "on_win", "difficulty_number", "init_attack_data", "handle_attacks", "count_items_in_container", "progress", "scanned",
        "check_light", "check_machine_gun", "level", "story_table",

        "tightspot_prices", "tightspot_make_offer", "tightspot_init", "tightspot_get_required_balance",
        "tightspot_init_level", "tightspot_init_spending_frame", "tightspot_init_progress_frame", "tightspot_update_progress", "tightspot_update_spending",
        "tightspot_get_missing_to_win", "tightspot_sell_back", "tightspot_start_level", "tightspot_show_level_description", "tightspot_update_speed_label",
        "map_ignore", "tightspot_check_level", "land_price",

        "transport_belt_madness_init", "transport_belt_madness_init_level", "transport_belt_madness_create_chests", "transport_belt_madness_fill_chests",
        "transport_belt_madness_start_level", "map_ignore", "map_clear", "map_load", "map_save", "transport_belt_madness_show_level_description",
        "transport_belt_madness_check_level", "transport_belt_madness_next_level", "transport_belt_madness_clear_level", "transport_belt_madness_contains_next_level",

        "restricted", "check_built_items", "result", "disable_combat_technologies", "apply_character_modifiers", "apply_combat_modifiers", "apply_balance",
        "load_config", "starting_area_constant", "create_next_surface", "end_round", "prepare_next_round", "silo_died","choose_joining_gui",
        "destroy_joining_guis", "create_random_join_gui", "create_auto_assign_gui", "create_pick_join_gui", "create_config_gui", "make_config_table", "default",
        "make_team_gui", "make_team_gui_config", "add_team_button_press", "trash_team_button_press", "remove_team_from_team_table", "add_team_to_team_table",
        "set_teams_from_gui", "on_team_button_press", "make_color_dropdown", "create_balance_option", "create_disable_frame", "disable_frame", "parse_disabled_items",
        "set_balance_settings", "config_confirm", "parse_config_from_gui", "get_color", "roll_starting_area", "delete_roll_surfaces", "auto_assign",
        "destroy_config_for_all", "prepare_map", "set_evolution_factor", "update_players_on_team_count", "random_join", "init_player_gui",
        "destroy_player_gui", "objective_button_press", "admin_button_press", "admin_frame_button_press", "diplomacy_button_press", "update_diplomacy_frame",
        "diplomacy_frame_button_press", "team_changed_diplomacy", "diplomacy_check_press", "get_stance", "give_inventory", "setup_teams", "disable_items_for_all",
        "set_random_team", "set_diplomacy", "create_spawn_positions", "set_spawn_position", "set_team_together_spawns", "chart_starting_area_for_force_spawns",
        "check_starting_area_chunks_are_generated", "check_player_color", "check_round_start", "clear_starting_area_enemies", "check_no_rush_end", "check_no_rush_players",
        "finish_setup", "chart_area_for_force", "setup_start_area_copy", "update_copy_progress", "update_progress_bar", "copy_paste_starting_area_tiles",
        "copy_paste_starting_area_entities", "create_silo_for_force", "setup_research", "on_chunk_generated", "get_distance_to_nearest_spawn",
        "create_wall_for_force", "fpn", "give_items", "create_item_frame", "create_technologies_frame", "create_cheat_frame", "create_day_frame",
        "time_modifier", "points_per_second_start", "points_per_second_level_subtract", "levels", "update_info", "get_time_left", "update_time_left",
        "on_joined", "make_frame", "update_frame", "update_table", "calculate_task_item_multiplayer", "setup_config", "select_from_probability_table",
        "select_inventory", "select_equipment", "select_challange_type", "save_round_statistics", "start_challenge", "create_teams", "set_areas",
        "decide_player_team", "set_teams", "refresh_leaderboard", "set_player", "generate_technology_list", "generate_research_task","setup_unlocks",
        "check_technology_progress", "generate_production_task", "generate_shopping_list_task", "set_gui_flow_table", "create_visibility_button",
        "check_item_lists", "update_task_gui", "check_end_of_round", "end_round_gui_update", "try_to_check_victory", "update_gui", "check_start_round",
        "check_start_set_areas", "check_start_setting_entities", "check_set_areas", "check_clear_areas", "check_chests", "check_chests_shopping_list",
        "check_chests_production", "check_input_chests", "fill_input_chests", "check_victory", "shopping_task_finished", "calculate_force_points",
        "update_research_task_table", "update_production_task_table", "update_shopping_list_task_table", "create_joined_game_gui", "pre_ending_round",
        "player_ending_prompt", "update_end_timer", "update_begin_timer", "team_finished", "save_points_list", "give_force_players_points",
        "update_winners_list", "set_spectator", "set_character", "give_starting_inventory", "give_equipment", "shuffle_table", "format_time",
        "spairs", "fill_leaderboard", "create_grid", "simple_entities", "save_map_data", "clear_map", "create_tiles", "recreate_entities",
        "map_sets", "give_points", "init_forces", "init_globals", "init_unit_settings", "check_next_wave", "next_wave", "calculate_wave_power",
        "wave_end", "make_next_spawn_tick", "check_spawn_units", "get_wave_units", "spawn_units", "randomize_ore", "set_command", "command_straglers",
        "unit_config", "make_next_wave_tick", "time_to_next_wave", "time_to_wave_end", "rocket_died", "unit_died", "get_bounty_price", "setup_waypoints",
        "insert_items", "give_starting_equipment", "give_spawn_equipment", "next_round_button_visible", "gui_init", "create_wave_frame", "create_money_frame",
        "create_upgrade_gui", "update_upgrade_listing", "upgrade_research", "get_upgrades", "get_money", "update_connected_players", "update_round_number",
        "set_research", "set_recipes", "check_deconstruction", "check_blueprint_placement", "create_entities_on_tick", "loop_entities", "experiment_items",
        "setup", "story_gui_click", "clear_surface", "add_run_trains_button", "puzzle_condition", "basic_signals",
        "loop_trains", "Y_offset", "clear_rails", "ghosts_1", "ghosts_2", "required_path", "through_wall_path", "count", "check_built_real_rail",
        "current_ghosts_count", "other", "rails", "set_rails", "straight_section", "late_entities", "entities", "stop",
    }
}

stds.factorio_base_data = {
    globals = {
        --Gui
        "make_cursor_box", "make_full_cursor_box", "make_orange_button_graphical_set", "make_blue_button_graphical_set",

        --Belts
        "transport_belt_connector_frame_sprites", "transport_belt_circuit_wire_connection_point", "transport_belt_circuit_wire_max_distance",
        "transport_belt_circuit_connector_sprites", "ending_patch_prototype", "basic_belt_horizontal", "basic_belt_vertical",
        "basic_belt_ending_top", "basic_belt_ending_bottom", "basic_belt_ending_side", "basic_belt_starting_top", "basic_belt_starting_bottom",
        "basic_belt_starting_side", "fast_belt_horizontal", "fast_belt_vertical", "fast_belt_ending_top", "fast_belt_ending_bottom",
        "fast_belt_ending_side", "fast_belt_starting_top", "fast_belt_starting_bottom", "fast_belt_starting_side", "express_belt_horizontal",
        "express_belt_vertical", "express_belt_ending_top", "express_belt_ending_bottom", "express_belt_ending_side", "express_belt_starting_top",
        "express_belt_starting_bottom", "express_belt_starting_side",

        --Circuit Connectors
        "get_circuit_connector_sprites", "get_circuit_connector_wire_shifting_for_connector",

        --Inserter Circuit Connectors
        "inserter_circuit_connector_sprites", "inserter_circuit_wire_connection_point", "inserter_circuit_wire_max_distance",
        "inserter_default_stack_control_input_signal",

        --Sounds/beams
        "make_heavy_gunshot_sounds", "make_light_gunshot_sounds", "make_laser_sounds",

        --Gun/Laser
        "gun_turret_extension", "gun_turret_extension_shadow", "gun_turret_extension_mask", "gun_turret_attack",
        "laser_turret_extension", "laser_turret_extension_shadow", "laser_turret_extension_mask",

        --Pipes
        "pipecoverspictures", "pipepictures", "assembler2pipepictures", "assembler3pipepictures", "make_heat_pipe_pictures",

        --Combinators
        --"generate_arithmetic_combinator", "generate_decider_combinator", "generate_constant_combinator",

        --Rail
        "destroyed_rail_pictures", "rail_pictures", "rail_pictures_internal", "standard_train_wheels", "drive_over_tie",
        "rolling_stock_back_light", "rolling_stock_stand_by_light",

        --Bugs
        "make_enemy_autoplace", "make_enemy_spawner_autoplace", "make_enemy_worm_autoplace",
        "make_spitter_attack_animation", "make_spitter_run_animation", "make_spitter_dying_animation",
        "make_spitter_attack_parameters", "make_spitter_roars", "make_spitter_dying_sounds",
        "make_spawner_idle_animation", "make_spawner_die_animation",
        "make_biter_run_animation", "make_biter_attack_animation", "make_biter_die_animation",
        "make_biter_roars", "make_biter_dying_sounds", "make_biter_calls",
        "make_worm_roars", "make_worm_dying_sounds", "make_worm_folded_animation", "make_worm_preparing_animation",
        "make_worm_prepared_animation", "make_worm_attack_animation", "make_worm_die_animation",

        --Other
        "tile_variations_template", "make_water_autoplace_settings",
        "make_unit_melee_ammo_type",  "make_trivial_smoke", "make_4way_animation_from_spritesheet", "make_flying_robot_sounds",
        "productivitymodulelimitation", "crash_trigger", "capsule_smoke",
    }
}

stds.factorio_base_story = {
    globals = {
        "story_init_helpers", "story_update_table", "story_init", "story_update", "story_on_tick", "story_add_update",
        "story_remove_update", "story_jump_to", "story_elapsed", "story_elapsed_check", "story_show_message_dialog",
        "set_goal", "player_set_goal", "on_player_joined", "flash_goal", "set_info", "player_set_info", "export_entities",
        "list", "recreate_entities", "entity_to_connect", "limit_camera", "find_gui_recursive", "enable_entity_export",
        "add_button", "on_gui_click", "set_continue_button_style", "add_message_log", "story_add_message_log",
        "player_add_message_log", "message_log_frame", "message_log_scrollpane", "message_log_close_button",
        "message_log_table", "toggle_message_log_button", "toggle_objective_button", "message_log_init",
        "add_gui_recursive", "add_toggle_message_log_button", "add_toggle_objective_button", "mod_gui",
        "flash_message_log_button", "flash_message_log_on_tick", "story_gui_click", "story_points_by_name", "story_branches",
    }
}

stds.stdlib = {
    read_globals = {
        -- Don't warn on mutated globals.
        table = {
            fields = {
                "map", "filter", "find", "any", "each", "flatten", "first", "last",
                "min", "max", "sum", "avg", "merge", "deepcopy", "values", "keys",
                "remove_keys", "invert", "count_keys", "size", "arr_to_bool",
            },
        },
        string = {
            fields = {
                "trim", "starts_with", "ends_with", "contains", "is_empty", "split", "pretty_number",
            },
        },
        iter = {
            read_only = true,
            other_fields = true,
        },
    }
}

stds.stdlib_control = {
    -- STDLIB globals
    globals = {
        Event = {
            other_fields = true,
            fields = {
                core_events = {
                    read_only = true,
                    other_fields = false,
                    fields = {
                        "init", "configuration_changed", "load", "_register", "init_and_config"
                    },
                },
            },
        },
        Gui = {
            fields = {
                on_click = {
                    read_only = true,
                },
                on_text_changed = {
                    read_only = true,
                },
                on_checked_state_changed = {
                    read_only = true,
                },
                on_elem_changed = {
                    read_only = true,
                },
                on_selection_state_changed = {
                    read_only = true
                }
            },
        },
        "Config",
        "Logger",
    },
}

stds.factorio_defines = {
    globals = {"creative_mode_defines"},
    read_globals = {
        defines = {
            fields = {
                events = {
                    fields = {
                        "script_raised_destroy",
                        "script_raised_built",
                        "script_raised_revive",
                        "on_biter_base_built", --Called when a biter migration builds a base.
                        "on_built_entity", --Called when player builds something.
                        "on_canceled_deconstruction", --Called when the deconstruction of an entity is canceled.
                        "on_chunk_generated", --Called when a chunk is generated.
                        "on_console_chat", --Called when someone talks in-game either a player or through the server interface.
                        "on_console_command", --Called when someone enters a command-like message regardless of it being a valid command.
                        "on_difficulty_settings_changed", --Called when the map difficulty settings are changed.
                        "on_entity_died", -- Called when an entity dies.
                        "on_entity_renamed", --Called after an entity has been renamed either by the player or through script.
                        "on_entity_settings_pasted", --Called after entity copy-paste is done.
                        "on_force_created", --Called when a new force is created using game.create_force()
                        "on_forces_merging", --Called when two forces are merged using game.merge_forces().
                        "on_gui_checked_state_changed", --Called when LuaGuiElement checked state is changed (related to checkboxes and radio buttons)
                        "on_gui_click", --Called when LuaGuiElement is clicked.
                        "on_gui_elem_changed", --Called when LuaGuiElement element value is changed (related to choose element buttons)
                        "on_gui_selection_state_changed", --Called when LuaGuiElement selection state is changed (related to drop-downs)
                        "on_gui_text_changed", --Called when LuaGuiElement text is changed by the player
                        "on_marked_for_deconstruction", --Called when an entity is marked for deconstruction with the Deconstruction planner or via script.
                        "on_market_item_purchased", --Called after a player purchases some offer from a Market entity.
                        "on_picked_up_item", --Called when a player picks up an item.
                        "on_player_alt_selected_area", --Called after a player alt-selects an area with a selection-tool item.
                        "on_player_ammo_inventory_changed", --Called after a players ammo inventory changed in some way.
                        "on_player_armor_inventory_changed", --Called after a players armor inventory changed in some way.
                        "on_player_built_tile", --Called after a player builds tiles.
                        "on_player_changed_force", --Called after a player changes forces.
                        "on_player_changed_surface", --Called after a player changes surfaces.
                        "on_player_configured_blueprint", --Called when a player clicks the "confirm" button in the configure Blueprint GUI.
                        "on_player_crafted_item", --Called when the player crafts an item (upon inserting into player's inventory, not clicking the button to craft).
                        "on_player_created", --Called after the player was created.
                        "on_player_cursor_stack_changed", --Called after a players cursorstack changed in some way.
                        "on_player_deconstructed_area", --Called when a player selects an area with a deconstruction planner.
                        "on_player_died", --Called after a player dies.
                        "on_player_driving_changed_state", --Called when the player's driving state has changed, this means a player has either entered or left a vehicle.
                        "on_player_dropped_item", --Called when a player drops an item on the ground.
                        "on_player_gun_inventory_changed", --Called after a players gun inventory changed in some way.
                        "on_player_joined_game", --Called after a player joins the game.
                        "on_player_left_game", --Called after a player leaves the game.
                        "on_player_main_inventory_changed", --Called after a players main inventory changed in some way.
                        "on_player_mined_entity", --Called after the results of an entity being mined are collected just before the entity is destroyed.
                        "on_player_mined_item", --Called when the player mines something.
                        "on_player_mined_tile", --Called after a player mines tiles.
                        "on_player_placed_equipment", --Called after the player puts equipment in an equipment grid
                        "on_player_quickbar_inventory_changed", --Called after a players quickbar inventory changed in some way.
                        "on_player_removed_equipment", --Called after the player removes equipment from an equipment grid
                        "on_player_respawned", --Called after a player respawns.
                        "on_player_rotated_entity", --Called when the player rotates an entity.
                        "on_player_selected_area", --Called after a player selects an area with a selection-tool item.
                        "on_player_setup_blueprint", --Called when a player selects an area with a blueprint.
                        "on_player_tool_inventory_changed", --Called after a players tool inventory changed in some way.
                        "on_pre_entity_settings_pasted", --Called before entity copy-paste is done.
                        "on_pre_player_died", --Called before a players dies.
                        "on_pre_surface_deleted", --Called just before a surface is deleted.
                        "on_pre_player_mined_item", --Called when the player finishes mining an entity, before the entity is removed from map.
                        "on_put_item", --Called when players uses item to build something.
                        "on_research_finished", --Called when a research finishes.
                        "on_research_started", --Called when a technology research starts.
                        "on_resource_depleted", --Called when a resource entity reaches 0 or its minimum yield for infinite resources.
                        "on_robot_built_entity", --Called when a construction robot builds an entity.
                        "on_robot_built_tile", --Called after a robot builds tiles.
                        "on_robot_mined", --Called when a robot mines an entity.
                        "on_robot_mined_entity", --Called after the results of an entity being mined are collected just before the entity is destroyed.
                        "on_robot_mined_tile", --Called after a robot mines tiles.
                        "on_robot_pre_mined", --Called before a robot mines an entity.
                        "on_rocket_launched", --Called when the rocket is launched.
                        "on_runtime_mod_setting_changed", --Called when a runtime mod setting is changed by a player.
                        "on_sector_scanned", --Called when the radar finishes scanning a sector.
                        "on_selected_entity_changed", --Called after the selected entity changes for a given player.
                        "on_surface_created", --Called when a surface is created.
                        "on_surface_deleted", --Called after a surface is deleted.
                        "on_tick", --It is fired once every tick.
                        "on_train_changed_state", --Called when a train changes state (started to stopped and vice versa)
                        "on_train_created", --Called when a new train is created either through disconnecting/connecting an existing one or building a new one.
                        "on_trigger_created_entity", --Called when an entity with a trigger prototype (such as capsules) create an entity AND that trigger prototype defined trigger_created_entity="true".
                        "on_player_removed", --Called when a player is deleted using remove_offline_players
                        "on_player_promoted",
                        "on_player_demoted",
                        "on_mod_gui_closed",
                        "on_combat_robot_expired",
                        "on_player_changed_position",
                        "on_mod_gui_closed",
                        "on_preplayer_mined_item", --DEPRECATED .16
                    },
                },
                alert_type = {
                    fields = {
                        "custom", "entity_destroyed", "entity_under_attack", "no_material_for_construction",
                        "no_storage", "not_enough_construction_robots", "not_enough_repair_packs", "turret_fire",
                    },
                },
                chain_signal_state = {
                    fields = {
                        "all_open", "none", "none_open", "partially_open",
                    },
                },
                chunk_generated_status = {
                    fields = {
                        "basic_tiles", "corrected_tiles", "custom_tiles", "entities", "nothing", "tiles",
                    },
                },
                circuit_condition_index = {
                    fields = {
                        "arithmetic_combinator", "constant_combinator", "decider_combinator", "inserter_circuit",
                        "inserter_logistic", "lamp", "offshore_pump", "pump",
                    },
                },
                circuit_connector_id = {
                    fields = {
                        "accumulator", "combinator_input", "combinator_output", "constant_combinator", "container",
                        "electric_pole", "inserter", "lamp", "offshore_pump", "programmable_speaker", "pump",
                        "rail_signal", "roboport", "storage_tank", "wall",
                    },
                },
                command = {
                    fields = {
                        "attack", "attack_area", "build_base", "compound", "go_to_location", "group", "wander",
                    },
                },
                compound_command = {
                    fields = {
                        "logical_and", "logical_or", "return_last",
                    },
                },
                control_behavior = {
                    fields = {
                        inserter = {
                            fields = {
                                circuit_mode_of_operation = {
                                    fields = {
                                        "enable_disable", "none", "read_hand_contents", "set_filters", "set_stack_size",
                                    },
                                },
                                hand_read_mode = {
                                    fields = {
                                        "hold", "pulse",
                                    }
                                },
                            },
                        },
                        lamp = {
                            fields = {
                                circuit_mode_of_operation = {
                                    fields = {
                                        "use_colors",
                                    }
                                },
                            },
                        },
                        logistic_container = {
                            fields = {
                                circuit_mode_of_operation = {
                                    fields = {
                                        "send_contents", "set_requests",
                                    }
                                },
                            },
                        },
                        mining_drill = {
                            fields = {
                                resource_read_mode = {
                                    fields = {
                                        "entire_patch", "this_miner",
                                    }
                                },
                            },
                        },
                        roboport = {
                            fields = {
                                circuit_mode_of_operation = {
                                    fields = {
                                        "read_logistics", "read_robot_stats",
                                    }
                                },
                            },
                        },
                        train_stop = {
                            fields = {
                                circuit_mode_of_operation = {
                                    fields = {
                                        "enable_disable", "read_from_train", "send_to_train",
                                    }
                                },
                            },
                        },
                        type = {
                            fields = {
                                "accumulator", "arithmetic_combinator", "constant_combinator", "container",
                                "decider_combinator", "generic_on_off", "inserter", "lamp", "logistic_container",
                                "rail_signal", "roboport", "storage_tank", "train_stop", "transport_belt",
                            },
                        },
                    },
                },
                controllers = {
                    fields = {
                        "character", "ghost", "god",
                    },
                },
                deconstruction_item = {
                    fields = {
                        entity_filter_mode = {
                            fields = {
                                "blacklist", "whitelist",
                            },
                        },
                        tile_filter_mode = {
                            fields = {
                                "always", "never", "normal", "only",
                            }
                        },
                    },
                },
                difficulty = {
                    fields = {
                        "easy", "hard", "normal",
                    },
                },
                difficulty_settings = {
                    fields = {
                        recipe_difficulty = {
                            fields = {
                                "expensive", "normal",
                            },
                        },
                        technology_difficulty = {
                            fields = {
                                "expensive", "normal",
                            }
                        },
                    },
                },
                direction = {
                    fields = {
                        "east", "north", "northeast", "northwest", "south", "southeast", "southwest", "west",
                    },
                },
                distraction = {
                    fields = {
                        "by_anything", "by_damage", "by_enemy", "none",
                    },
                },
                group_state = {
                    fields = {
                        "attacking_distraction", "attacking_target", "finished", "gathering", "moving",
                    },
                },
                gui_type = {
                    fields = {
                        "achievement", "blueprint_library", "bonus", "controller", "entity", "equipment", "item",
                        "kills", "logistic", "none", "other_player", "permissions", "production", "research",
                        "trains", "tutorials", "custom",
                    },
                },
                input_action = {
                    fields = {
                        "add_permission_group", "alt_select_area", "alt_select_blueprint_entities", "begin_mining",
                        "begin_mining_terrain", "build_item", "build_rail", "build_terrain", "cancel_craft",
                        "cancel_deconstruct", "cancel_new_blueprint", "cancel_research", "change_active_item_group_for_crafting",
                        "change_active_item_group_for_filters", "change_active_quick_bar", "change_arithmetic_combinator_parameters",
                        "change_blueprint_book_record_label", "change_decider_combinator_parameters", "change_item_label",
                        "change_picking_state", "change_programmable_speaker_alert_parameters", "change_programmable_speaker_circuit_parameters",
                        "change_programmable_speaker_parameters", "change_riding_state", "change_shooting_state",
                        "change_single_blueprint_record_label", "change_train_stop_station", "change_train_wait_condition",
                        "change_train_wait_condition_data", "clean_cursor_stack", "clear_blueprint", "clear_selected_blueprint",
                        "clear_selected_deconstruction_item", "connect_rolling_stock", "copy_entity_settings", "craft",
                        "craft_blueprint_record", "create_blueprint_like", "cursor_split", "cursor_transfer", "custom_input",
                        "cycle_blueprint_book_backwards", "cycle_blueprint_book_forwards", "deconstruct", "delete_blueprint_record",
                        "delete_custom_tag", "delete_permission_group", "disconnect_rolling_stock", "drop_blueprint_record",
                        "drop_item", "drop_to_blueprint_book", "edit_custom_tag", "edit_permission_group", "edit_train_schedule",
                        "export_blueprint", "fast_entity_split", "fast_entity_transfer", "grab_blueprint_record", "gui_checked_state_changed",
                        "gui_click", "gui_elem_selected", "gui_selection_state_changed", "gui_text_changed", "import_blueprint",
                        "import_blueprint_string", "inventory_split", "inventory_transfer", "launch_rocket", "market_offer",
                        "mod_settings_changed", "open_achievements_gui", "open_blueprint_library_gui", "open_blueprint_record",
                        "open_bonus_gui", "open_character_gui", "open_equipment", "open_gui", "open_item", "open_kills_gui",
                        "open_logistic_gui", "open_production_gui", "open_technology_gui", "open_train_gui", "open_train_station_gui",
                        "open_trains_gui", "open_tutorials_gui", "paste_entity_settings", "place_equipment", "remove_cables",
                        "reset_assembling_machine", "reverse_rotate_entity", "rotate_entity", "select_area", "select_blueprint_entities",
                        "select_entity_slot", "select_gun", "select_item", "select_tile_slot", "set_auto_launch_rocket", "set_autosort_inventory",
                        "set_behavior_mode", "set_blueprint_icon", "set_circuit_condition", "set_circuit_mode_of_operation",
                        "set_deconstruction_item_tile_selection_mode", "set_deconstruction_item_trees_only", "set_entity_color",
                        "set_entity_energy_property", "set_filter", "set_inserter_max_stack_size", "set_inventory_bar", "set_logistic_filter_item",
                        "set_logistic_filter_signal", "set_logistic_trash_filter_item", "set_research_finished_stops_game", "set_signal",
                        "set_single_blueprint_record_icon", "set_train_stopped", "set_use_item_groups", "setup_assembling_machine",
                        "setup_blueprint", "setup_single_blueprint_record", "shortcut_quick_bar_transfer", "smart_pipette", "stack_split",
                        "stack_transfer", "start_repair", "start_research", "start_walking", "switch_connect_to_logistic_network",
                        "switch_constant_combinator_state", "switch_power_switch_state", "switch_to_rename_stop_gui", "take_equipment",
                        "toggle_connect_center_back_tank", "toggle_connect_front_center_tank", "toggle_deconstruction_item_entity_filter_mode",
                        "toggle_deconstruction_item_tile_filter_mode", "toggle_driving", "toggle_enable_vehicle_logistics_while_moving",
                        "toggle_entity_on_off_state", "toggle_show_entity_info", "use_ability", "use_item", "wire_dragging", "write_to_console",
                    },
                },
                inventory = {
                    fields = {
                        "assembling_machine_input", "assembling_machine_modules", "assembling_machine_output", "beacon_modules",
                        "burnt_result", "car_ammo", "car_trunk", "cargo_wagon", "chest", "fuel", "furnace_modules",
                        "furnace_result", "furnace_source", "god_main", "god_quickbar", "item_main", "lab_input", "lab_modules",
                        "mining_drill_modules", "player_ammo", "player_armor", "player_guns", "player_main", "player_quickbar",
                        "player_tools", "player_trash", "player_vehicle", "roboport_material", "roboport_robot", "rocket_silo_result",
                        "rocket_silo_rocket", "turret_ammo",
                    },
                },
                logistic_member_index = {
                    fields = {
                        "character_provider", "character_requester", "character_storage", "generic_on_off_behavior", "logistic_container", "vehicle_storage",
                    },
                },
                logistic_mode = {
                    fields = {
                        "active_provider", "none", "passive_provider", "requester", "storage", "buffer"
                    },
                },
                mouse_button_type = {
                    fields = {
                        "left", "middle", "none", "right",
                    },
                },
                rail_connection_direction = {
                    fields = {
                        "left", "none", "right", "straight",
                    },
                },
                rail_direction = {
                    fields = {
                        "back", "front",
                    },
                },
                riding = {
                    fields = {
                        acceleration = {
                            fields = {
                                "accelerating", "braking", "nothing", "reversing",
                            },
                        },
                        direction = {
                            fields = {
                                "left", "right", "straight",
                            }
                        },
                    },
                },
                shooting = {
                    fields = {
                        "not_shooting", "shooting_enemies", "shooting_selected",
                    },
                },
                signal_state = {
                    fields = {
                        "closed", "open", "reserved", "reserved_by_circuit_network",
                    },
                },
                train_state = {
                    fields = {
                        "arrive_signal", "arrive_station", "manual_control", "manual_control_stop", "no_path", "no_schedule",
                        "on_the_path", "path_lost", "stop_for_auto_control", "wait_signal", "wait_station",
                    },
                },
                transport_line = {
                    fields = {
                        "left_line", "left_split_line", "left_underground_line", "right_line", "right_split_line", "right_underground_line",
                        "secondary_left_line", "secondary_left_split_line", "secondary_right_line", "secondary_right_split_line",
                    },
                },
                wire_type = {
                    fields = {
                        "copper", "green", "red",
                    }
                },
                -- Deprecated
                colors = {
                    other_fields = true,
                },
                -- Deprecated
                anticolors = {
                    other_fields = true,
                },
                -- Deprecated
                lightcolors = {
                    other_fields = true,
                },
                color = {
                    other_fields = true,
                },
                anticolor = {
                    other_fields = true,
                },
                lightcolor = {
                    other_fields = true,
                },
                time = {
                    fields = {
                        "second", "minute", "hour", "day", "week", "month", "year",
                    }
                },
            },
        }
    }
}

-- Warnings list
-- 011 A syntax error.
-- 021 An invalid inline option.
-- 022 An unpaired inline push directive.
-- 023 An unpaired inline pop directive.
-- 111 Setting an undefined global variable.
-- 112 Mutating an undefined global variable.
-- 113 Accessing an undefined global variable.
-- 121 Setting a read-only global variable.
-- 122 Setting a read-only field of a global variable.
-- 131 Unused implicitly defined global variable.
-- 142 Setting an undefined field of a global variable.
-- 143 Accessing an undefined field of a global variable.
-- 211 Unused local variable.
-- 212 Unused argument.
-- 213 Unused loop variable.
-- 221 Local variable is accessed but never set.
-- 231 Local variable is set but never accessed.
-- 232 An argument is set but never accessed.
-- 233 Loop variable is set but never accessed.
-- 241 Local variable is mutated but never accessed.
-- 311 Value assigned to a local variable is unused.
-- 312 Value of an argument is unused.
-- 313 Value of a loop variable is unused.
-- 314 Value of a field in a table literal is unused.
-- 321 Accessing uninitialized local variable.
-- 331 Value assigned to a local variable is mutated but never accessed.
-- 341 Mutating uninitialized local variable.
-- 411 Redefining a local variable.
-- 412 Redefining an argument.
-- 413 Redefining a loop variable.
-- 421 Shadowing a local variable.
-- 422 Shadowing an argument.
-- 423 Shadowing a loop variable.
-- 431 Shadowing an upvalue.
-- 432 Shadowing an upvalue argument.
-- 433 Shadowing an upvalue loop variable.
-- 511 Unreachable code.
-- 512 Loop can be executed at most once.
-- 521 Unused label.
-- 531 Left-hand side of an assignment is too short.
-- 532 Left-hand side of an assignment is too long.
-- 541 An empty do end block.
-- 542 An empty if branch.
-- 551 An empty statement.
-- 611 A line consists of nothing but whitespace.
-- 612 A line contains trailing whitespace.
-- 613 Trailing whitespace in a string.
-- 614 Trailing whitespace in a comment.
-- 621 Inconsistent indentation (SPACE followed by TAB).
-- 631 Line is too long.
