extends AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.play_sfx.connect(_on_play_sfx_play_sound);


func _on_play_sfx_play_sound(path: String):
	var sound = load(path);
	self.stream = sound;
	self.play();
