class_name ConnectionUnit
extends Control

@export var icon: Texture2D;
@export var connection_type: Enums.ConnectionType;

@onready var icon_texture: TextureRect = get_node("%ConnectorIcon");
@onready var connection_button: Button = get_node("%ToggleConnectionButton");
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	icon_texture.texture = icon;
