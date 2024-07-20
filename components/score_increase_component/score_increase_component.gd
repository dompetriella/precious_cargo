extends Node2D

@export var health_component: HealthComponent;
@export var score_increase: int = 10;

func _increase_score(score_increase: int):
	Events.increase_game_score.emit(score_increase);
