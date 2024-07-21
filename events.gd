extends Node

signal increase_game_score(score_increase: int);
signal damage_player(enemy_damage: int);
signal heal_player(heal_amount: int);
signal change_heat_amount(heat_amount: int);
signal change_energy_level(energy_amount: int);

signal toggle_heatsinks(connected: bool);
signal toggle_thrusters(connected: bool);
signal toggle_shields(connected: bool);
signal toggle_powershot(connected: bool);
signal toggle_engineer_o2(connected: bool);
signal toggle_passenger_o2(connected: bool);
signal send_passenger_bonus(bonus_multiplier: float);

signal play_sfx(media: String);
signal play_sfx_player(media: String);

signal player_has_died(reason_for_death: String);

signal decrease_spawn_time();
