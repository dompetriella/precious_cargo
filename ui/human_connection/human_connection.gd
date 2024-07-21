extends Control

@export var icon: Texture2D;
@export var connection_type: Enums.ConnectionType;
@onready var connection_button: Button = get_node("%HumanToggleConnectionButton");
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass;
