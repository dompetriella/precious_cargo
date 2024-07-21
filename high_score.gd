extends Node

var high_score: int = 0;
var spawn_timer: float = 3;

func _ready() -> void:
	Events.decrease_spawn_time.connect(
		func():
			spawn_timer -= 0.10
	);
