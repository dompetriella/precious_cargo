extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	var parent = get_parent();
	var info: PackedScene = load("res://ui/main_menu/info.tscn");
	var info_instance = info.instantiate();
	parent.add_child(info_instance);
