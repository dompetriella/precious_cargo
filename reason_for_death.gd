extends Node

var reason_for_death: String = "";
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.player_has_died.connect(
		func(message: String):
			reason_for_death = message;
	)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
