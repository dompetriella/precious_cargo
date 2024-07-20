extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.increase_game_score.connect(_add_points_to_score);

func _add_points_to_score(points: int):
	var old_score: int = int(text.split(" ")[1]);
	self.text = "Score: " + str(old_score + (points * 100));

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
