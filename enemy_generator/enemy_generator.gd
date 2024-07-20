extends Node

var standard_enemy: PackedScene = preload("res://enemy/standard.tscn");

@onready var leftMarker: Marker2D = get_node("%LeftSpawnBoundary");
@onready var rightMarker = get_node("%RightSpawnBoundary");


func _on_generate_timer_timeout() -> void:
	var new_x_coordinate = (randi() % int(rightMarker.global_position.x) + int(leftMarker.global_position.x));
	print(new_x_coordinate);
	var new_y_coordinate = leftMarker.global_position.y;
	var new_enemy_position = Vector2(new_x_coordinate, new_y_coordinate);
	var new_enemy_instance: Node2D = standard_enemy.instantiate();
	new_enemy_instance.global_position = new_enemy_position;
	self.add_child(new_enemy_instance);
	
