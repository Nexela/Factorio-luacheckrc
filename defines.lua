-- luacheck: ignore
stds.factorio_defines = {
    read_globals = {
        defines = {
            fields = {
                alert_type = {
                    fields = {
                        'custom',
                        'entity_destroyed',
                        'entity_under_attack',
                        'no_material_for_construction',
                        'no_storage',
                        'not_enough_construction_robots',
                        'not_enough_repair_packs',
                        'train_out_of_fuel',
                        'turret_fire'
                    }
                },
                behavior_result = {
                    fields = {
                        'deleted',
                        'fail',
                        'in_progress',
                        'success'
                    }
                },
                build_check_type = {
                    fields = {
                        'ghost_place',
                        'ghost_revive',
                        'manual',
                        'script'
                    }
                },
                chain_signal_state = {
                    fields = {
                        'all_open',
                        'none',
                        'none_open',
                        'partially_open'
                    }
                },
                chunk_generated_status = {
                    fields = {
                        'basic_tiles',
                        'corrected_tiles',
                        'custom_tiles',
                        'entities',
                        'nothing',
                        'tiles'
                    }
                },
                circuit_condition_index = {
                    fields = {
                        'arithmetic_combinator',
                        'constant_combinator',
                        'decider_combinator',
                        'inserter_circuit',
                        'inserter_logistic',
                        'lamp',
                        'offshore_pump',
                        'pump'
                    }
                },
                circuit_connector_id = {
                    fields = {
                        'accumulator',
                        'combinator_input',
                        'combinator_output',
                        'constant_combinator',
                        'container',
                        'electric_pole',
                        'inserter',
                        'lamp',
                        'offshore_pump',
                        'programmable_speaker',
                        'pump',
                        'rail_chain_signal',
                        'rail_signal',
                        'roboport',
                        'storage_tank',
                        'wall'
                    }
                },
                command = {
                    fields = {
                        'attack',
                        'attack_area',
                        'build_base',
                        'compound',
                        'flee',
                        'go_to_location',
                        'group',
                        'stop',
                        'wander'
                    }
                },
                compound_command = {
                    fields = {
                        'logical_and',
                        'logical_or',
                        'return_last'
                    }
                },
                control_behavior = {
                    fields = {
                        inserter = {
                            fields = {
                                circuit_mode_of_operation = {
                                    fields = {
                                        'enable_disable',
                                        'none',
                                        'read_hand_contents',
                                        'set_filters',
                                        'set_stack_size'
                                    }
                                },
                                hand_read_mode = {
                                    fields = {
                                        'hold',
                                        'pulse'
                                    }
                                }
                            }
                        },
                        lamp = {
                            fields = {
                                circuit_mode_of_operation = {
                                    fields = {
                                        'use_colors'
                                    }
                                }
                            }
                        },
                        logistic_container = {
                            fields = {
                                circuit_mode_of_operation = {
                                    fields = {
                                        'send_contents',
                                        'set_requests'
                                    }
                                }
                            }
                        },
                        mining_drill = {
                            fields = {
                                resource_read_mode = {
                                    fields = {
                                        'entire_patch',
                                        'this_miner'
                                    }
                                }
                            }
                        },
                        roboport = {
                            fields = {
                                circuit_mode_of_operation = {
                                    fields = {
                                        'read_logistics',
                                        'read_robot_stats'
                                    }
                                }
                            }
                        },
                        train_stop = {
                            fields = {
                                circuit_mode_of_operation = {
                                    fields = {
                                        'enable_disable',
                                        'read_from_train',
                                        'read_stopped_train',
                                        'send_to_train'
                                    }
                                }
                            }
                        },
                        transport_belt = {
                            fields = {
                                content_read_mode = {
                                    fields = {
                                        'hold',
                                        'pulse'
                                    }
                                }
                            }
                        },
                        type = {
                            fields = {
                                'accumulator',
                                'arithmetic_combinator',
                                'constant_combinator',
                                'container',
                                'decider_combinator',
                                'generic_on_off',
                                'inserter',
                                'lamp',
                                'logistic_container',
                                'mining_drill',
                                'programmable_speaker',
                                'rail_chain_signal',
                                'rail_signal',
                                'roboport',
                                'storage_tank',
                                'train_stop',
                                'transport_belt',
                                'wall'
                            }
                        }
                    }
                },
                controllers = {
                    fields = {
                        'character',
                        'editor',
                        'ghost',
                        'god',
                        'spectator'
                    }
                },
                crafting_machine_status = {
                    fields = {
                        'fluid_ingredient_shortage',
                        'fluid_production_overload',
                        'item_ingredient_shortage',
                        'item_production_overload',
                        'low_power',
                        'no_fluid_inventory',
                        'no_item_inventory',
                        'no_power',
                        'no_recipe',
                        'none',
                        'working'
                    }
                },
                deconstruction_item = {
                    fields = {
                        entity_filter_mode = {
                            fields = {
                                'blacklist',
                                'whitelist'
                            }
                        },
                        tile_filter_mode = {
                            fields = {
                                'blacklist',
                                'whitelist'
                            }
                        },
                        tile_selection_mode = {
                            fields = {
                                'always',
                                'never',
                                'normal',
                                'only'
                            }
                        }
                    }
                },
                difficulty = {
                    fields = {
                        'easy',
                        'hard',
                        'normal'
                    }
                },
                difficulty_settings = {
                    fields = {
                        recipe_difficulty = {
                            fields = {
                                'expensive',
                                'normal'
                            }
                        },
                        technology_difficulty = {
                            fields = {
                                'expensive',
                                'normal'
                            }
                        }
                    }
                },
                direction = {
                    fields = {
                        'east',
                        'north',
                        'northeast',
                        'northwest',
                        'south',
                        'southeast',
                        'southwest',
                        'west'
                    }
                },
                distraction = {
                    fields = {
                        'by_anything',
                        'by_damage',
                        'by_enemy',
                        'none'
                    }
                },
                entity_status = {
                    fields = {
                        'working',
                        'no_power',
                        'no_fuel',
                        'no_recipe',
                        'no_input_fluid',
                        'no_research_in_progress',
                        'no_minable_resources',
                        'low_input_fluid',
                        'low_power',
                        'disabled_by_control_behavior',
                        'disabled_by_script',
                        'fluid_ingredient_shortage',
                        'fluid_production_overload',
                        'item_ingredient_shortage',
                        'item_production_overload',
                        'marked_for_deconstruction',
                        'missing_required_fluid',
                        'missing_science_packs',
                        'waiting_for_source_items',
                        'waiting_for_space_in_destination',
                    }
                },
                events = {
                    fields = {
                        'on_ai_command_completed',
                        'on_area_cloned',
                        'on_biter_base_built',
                        'on_built_entity',
                        'on_canceled_deconstruction',
                        'on_cancelled_upgrade',
                        'on_character_corpse_expired',
                        'on_chunk_charted',
                        'on_chunk_deleted',
                        'on_chunk_generated',
                        'on_combat_robot_expired',
                        'on_console_chat',
                        'on_console_command',
                        'on_difficulty_settings_changed',
                        'on_entity_cloned',
                        'on_entity_damaged',
                        'on_entity_died',
                        'on_entity_renamed',
                        'on_entity_settings_pasted',
                        'on_force_created',
                        'on_forces_merged',
                        'on_forces_merging',
                        'on_game_created_from_scenario',
                        'on_gui_checked_state_changed',
                        'on_gui_click',
                        'on_gui_closed',
                        'on_gui_elem_changed',
                        'on_gui_opened',
                        'on_gui_selection_state_changed',
                        'on_gui_text_changed',
                        'on_gui_value_changed',
                        'on_land_mine_armed',
                        'on_marked_for_deconstruction',
                        'on_marked_for_upgrade',
                        'on_market_item_purchased',
                        'on_mod_item_opened',
                        'on_picked_up_item',
                        'on_player_alt_selected_area',
                        'on_player_ammo_inventory_changed',
                        'on_player_armor_inventory_changed',
                        'on_player_banned',
                        'on_player_built_tile',
                        'on_player_cancelled_crafting',
                        'on_player_changed_force',
                        'on_player_changed_position',
                        'on_player_changed_surface',
                        'on_player_cheat_mode_disabled',
                        'on_player_cheat_mode_enabled',
                        'on_player_configured_blueprint',
                        'on_player_crafted_item',
                        'on_player_created',
                        'on_player_cursor_stack_changed',
                        'on_player_deconstructed_area',
                        'on_player_demoted',
                        'on_player_died',
                        'on_player_display_resolution_changed',
                        'on_player_display_scale_changed',
                        'on_player_driving_changed_state',
                        'on_player_dropped_item',
                        'on_player_fast_transferred',
                        'on_player_gun_inventory_changed',
                        'on_player_joined_game',
                        'on_player_kicked',
                        'on_player_left_game',
                        'on_player_main_inventory_changed',
                        'on_player_mined_entity',
                        'on_player_mined_item',
                        'on_player_mined_tile',
                        'on_player_muted',
                        'on_player_pipette',
                        'on_player_placed_equipment',
                        'on_player_promoted',
                        'on_player_quickbar_inventory_changed',
                        'on_player_removed',
                        'on_player_removed_equipment',
                        'on_player_repaired_entity',
                        'on_player_respawned',
                        'on_player_rotated_entity',
                        'on_player_selected_area',
                        'on_player_setup_blueprint',
                        'on_player_toggled_alt_mode',
                        'on_player_toggled_map_editor',
                        'on_player_tool_inventory_changed',
                        'on_player_trash_inventory_changed',
                        'on_player_unbanned',
                        'on_player_unmuted',
                        'on_player_used_capsule',
                        'on_pre_chunk_deleted',
                        'on_pre_entity_settings_pasted',
                        'on_pre_ghost_deconstructed',
                        'on_pre_player_crafted_item',
                        'on_pre_player_died',
                        'on_pre_player_left_game',
                        'on_pre_player_mined_item',
                        'on_pre_surface_cleared',
                        'on_pre_surface_deleted',
                        'on_put_item',
                        'on_research_finished',
                        'on_research_started',
                        'on_resource_depleted',
                        'on_robot_built_entity',
                        'on_robot_built_tile',
                        'on_robot_mined',
                        'on_robot_mined_entity',
                        'on_robot_mined_tile',
                        'on_robot_pre_mined',
                        'on_rocket_launch_ordered',
                        'on_rocket_launched',
                        'on_runtime_mod_setting_changed',
                        'on_script_path_request_finished',
                        'on_sector_scanned',
                        'on_selected_entity_changed',
                        'on_surface_cleared',
                        'on_surface_created',
                        'on_surface_deleted',
                        'on_surface_imported',
                        'on_surface_renamed',
                        'on_technology_effects_reset',
                        'on_tick',
                        'on_train_changed_state',
                        'on_train_created',
                        'on_train_schedule_changed',
                        'on_trigger_created_entity',
                        'script_raised_built',
                        'script_raised_destroy',
                        'script_raised_revive'
                    }
                },
                flow_precision_index = {
                    fields = {
                        'fifty_hours',
                        'one_hour',
                        'one_minute',
                        'one_second',
                        'one_thousand_hours',
                        'ten_hours',
                        'ten_minutes',
                        'two_hundred_fifty_hours'
                    }
                },
                group_state = {
                    fields = {
                        'attacking_distraction',
                        'attacking_target',
                        'finished',
                        'gathering',
                        'moving'
                    }
                },
                gui_type = {
                    fields = {
                        'achievement',
                        'blueprint_library',
                        'bonus',
                        'controller',
                        'custom',
                        'entity',
                        'equipment',
                        'item',
                        'kills',
                        'logistic',
                        'none',
                        'other_player',
                        'permissions',
                        'production',
                        'research',
                        'trains',
                        'tutorials'
                    }
                },
                input_action = {
                    fields = {
                        'activate_copy',
                        'activate_cut',
                        'activate_paste',
                        'add_permission_group',
                        'alt_select_area',
                        'alt_select_blueprint_entities',
                        'alternative_copy',
                        'begin_mining',
                        'begin_mining_terrain',
                        'build_item',
                        'build_rail',
                        'build_terrain',
                        'cancel_craft',
                        'cancel_deconstruct',
                        'cancel_new_blueprint',
                        'cancel_research',
                        'cancel_upgrade',
                        'change_active_item_group_for_crafting',
                        'change_active_item_group_for_filters',
                        'change_active_quick_bar',
                        'change_arithmetic_combinator_parameters',
                        'change_blueprint_book_record_label',
                        'change_decider_combinator_parameters',
                        'change_item_label',
                        'change_picking_state',
                        'change_programmable_speaker_alert_parameters',
                        'change_programmable_speaker_circuit_parameters',
                        'change_programmable_speaker_parameters',
                        'change_riding_state',
                        'change_shooting_state',
                        'change_single_blueprint_record_label',
                        'change_train_stop_station',
                        'change_train_wait_condition',
                        'change_train_wait_condition_data',
                        'clean_cursor_stack',
                        'clear_selected_blueprint',
                        'clear_selected_deconstruction_item',
                        'clear_selected_upgrade_item',
                        'clone_item',
                        'connect_rolling_stock',
                        'copy',
                        'copy_entity_settings',
                        'craft',
                        'create_blueprint_like',
                        'cursor_split',
                        'cursor_transfer',
                        'custom_input',
                        'cycle_blueprint_book_backwards',
                        'cycle_blueprint_book_forwards',
                        'deconstruct',
                        'delete_blueprint_record',
                        'delete_custom_tag',
                        'delete_permission_group',
                        'destroy_opened_item',
                        'disconnect_rolling_stock',
                        'drag_train_schedule',
                        'drag_train_wait_condition',
                        'drop_blueprint_record',
                        'drop_item',
                        'drop_to_blueprint_book',
                        'edit_custom_tag',
                        'edit_permission_group',
                        'edit_train_schedule',
                        'export_blueprint',
                        'fast_entity_split',
                        'fast_entity_transfer',
                        'grab_blueprint_record',
                        'gui_checked_state_changed',
                        'gui_click',
                        'gui_elem_changed',
                        'gui_selection_state_changed',
                        'gui_text_changed',
                        'gui_value_changed',
                        'import_blueprint',
                        'import_blueprint_string',
                        'import_permissions_string',
                        'inventory_split',
                        'inventory_transfer',
                        'launch_rocket',
                        'map_editor_action',
                        'market_offer',
                        'mod_settings_changed',
                        'open_achievements_gui',
                        'open_blueprint_library_gui',
                        'open_blueprint_record',
                        'open_bonus_gui',
                        'open_character_gui',
                        'open_equipment',
                        'open_gui',
                        'open_item',
                        'open_kills_gui',
                        'open_logistic_gui',
                        'open_mod_item',
                        'open_production_gui',
                        'open_technology_gui',
                        'open_train_gui',
                        'open_train_station_gui',
                        'open_trains_gui',
                        'open_tutorials_gui',
                        'paste_entity_settings',
                        'place_equipment',
                        'remove_cables',
                        'reset_assembling_machine',
                        'rotate_entity',
                        'select_area',
                        'select_blueprint_entities',
                        'select_entity_slot',
                        'select_item',
                        'select_mapper_slot',
                        'select_next_valid_gun',
                        'select_tile_slot',
                        'set_auto_launch_rocket',
                        'set_autosort_inventory',
                        'set_behavior_mode',
                        'set_car_weapons_control',
                        'set_circuit_condition',
                        'set_circuit_mode_of_operation',
                        'set_deconstruction_item_tile_selection_mode',
                        'set_deconstruction_item_trees_and_rocks_only',
                        'set_entity_color',
                        'set_entity_energy_property',
                        'set_filter',
                        'set_heat_interface_mode',
                        'set_heat_interface_temperature',
                        'set_infinity_container_filter_item',
                        'set_infinity_container_remove_unfiltered_items',
                        'set_infinity_pipe_filter',
                        'set_inserter_max_stack_size',
                        'set_inventory_bar',
                        'set_logistic_filter_item',
                        'set_logistic_filter_signal',
                        'set_logistic_trash_filter_item',
                        'set_request_from_buffers',
                        'set_research_finished_stops_game',
                        'set_signal',
                        'set_single_blueprint_record_icon',
                        'set_splitter_priority',
                        'set_train_stopped',
                        'setup_assembling_machine',
                        'setup_blueprint',
                        'setup_single_blueprint_record',
                        'shortcut_quick_bar_transfer',
                        'smart_pipette',
                        'stack_split',
                        'stack_transfer',
                        'start_repair',
                        'start_research',
                        'start_walking',
                        'switch_connect_to_logistic_network',
                        'switch_constant_combinator_state',
                        'switch_inserter_filter_mode_state',
                        'switch_power_switch_state',
                        'switch_to_rename_stop_gui',
                        'take_equipment',
                        'toggle_deconstruction_item_entity_filter_mode',
                        'toggle_deconstruction_item_tile_filter_mode',
                        'toggle_driving',
                        'toggle_enable_vehicle_logistics_while_moving',
                        'toggle_map_editor',
                        'toggle_show_entity_info',
                        'undo',
                        'upgrade',
                        'use_ability',
                        'use_artillery_remote',
                        'use_item',
                        'wire_dragging',
                        'write_to_console'
                    }
                },
                inventory = {
                    fields = {
                        'artillery_turret_ammo',
                        'artillery_wagon_ammo',
                        'assembling_machine_input',
                        'assembling_machine_modules',
                        'assembling_machine_output',
                        'beacon_modules',
                        'burnt_result',
                        'car_ammo',
                        'car_trunk',
                        'cargo_wagon',
                        'character_corpse',
                        'chest',
                        'fuel',
                        'furnace_modules',
                        'furnace_result',
                        'furnace_source',
                        'god_main',
                        'god_quickbar',
                        'item_main',
                        'lab_input',
                        'lab_modules',
                        'mining_drill_modules',
                        'player_ammo',
                        'player_armor',
                        'player_guns',
                        'player_main',
                        'player_quickbar',
                        'player_tools',
                        'player_trash',
                        'player_vehicle',
                        'roboport_material',
                        'roboport_robot',
                        'robot_cargo',
                        'robot_repair',
                        'rocket',
                        'rocket_silo_result',
                        'rocket_silo_rocket',
                        'turret_ammo'
                    }
                },
                logistic_member_index = {
                    fields = {
                        'character_provider',
                        'character_requester',
                        'character_storage',
                        'generic_on_off_behavior',
                        'logistic_container',
                        'vehicle_storage'
                    }
                },
                logistic_mode = {
                    fields = {
                        'active_provider',
                        'buffer',
                        'none',
                        'passive_provider',
                        'requester',
                        'storage'
                    }
                },
                mouse_button_type = {
                    fields = {
                        'left',
                        'middle',
                        'none',
                        'right'
                    }
                },
                rail_connection_direction = {
                    fields = {
                        'left',
                        'none',
                        'right',
                        'straight'
                    }
                },
                rail_direction = {
                    fields = {
                        'back',
                        'front'
                    }
                },
                riding = {
                    fields = {
                        acceleration = {
                            fields = {
                                'accelerating',
                                'braking',
                                'nothing',
                                'reversing'
                            }
                        },
                        direction = {
                            fields = {
                                'left',
                                'right',
                                'straight'
                            }
                        }
                    }
                },
                shooting = {
                    fields = {
                        'not_shooting',
                        'shooting_enemies',
                        'shooting_selected'
                    }
                },
                signal_state = {
                    fields = {
                        'closed',
                        'open',
                        'reserved',
                        'reserved_by_circuit_network'
                    }
                },
                train_state = {
                    fields = {
                        'arrive_signal',
                        'arrive_station',
                        'manual_control',
                        'manual_control_stop',
                        'no_path',
                        'no_schedule',
                        'on_the_path',
                        'path_lost',
                        'wait_signal',
                        'wait_station'
                    }
                },
                transport_line = {
                    fields = {
                        'left_line',
                        'left_split_line',
                        'left_underground_line',
                        'right_line',
                        'right_split_line',
                        'right_underground_line',
                        'secondary_left_line',
                        'secondary_left_split_line',
                        'secondary_right_line',
                        'secondary_right_split_line'
                    }
                },
                wire_connection_id = {
                    fields = {
                        'electric_pole',
                        'power_switch_left',
                        'power_switch_right'
                    }
                },
                wire_type = {
                    fields = {
                        'copper',
                        'green',
                        'red'
                    }
                },
                -- Defines additional modules
                color = {
                    other_fields = true
                },
                anticolor = {
                    other_fields = true
                },
                lightcolor = {
                    other_fields = true
                },
                time = {
                    fields = {
                        'second',
                        'minute',
                        'hour',
                        'day',
                        'week',
                        'month',
                        'year'
                    }
                }
            }
        }
    }
}
