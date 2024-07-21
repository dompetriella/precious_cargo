extends Node

var standard_enemy: PackedScene = preload("res://enemy/standard.tscn");
var ufo: PackedScene = preload("res://enemy/ufo.tscn");
var speedster: PackedScene = preload("res://enemy/speedster.tscn");

@onready var leftMarker: Marker2D = get_node("%LeftSpawnBoundary");
@onready var rightMarker = get_node("%RightSpawnBoundary");

var previous_spawns: Array[int] = []
var max_attempts: int = 100

func _on_generate_timer_timeout() -> void:
	var possible_spawns: Array[PackedScene] = [standard_enemy, ufo, speedster];
	var rand_index:int = randi() % possible_spawns.size();
	var new_x_coordinate: int
	var attempts: int = 0
	
	if (previous_spawns.size() > 4):
		previous_spawns.remove_at(0)
		
	while (attempts < max_attempts):
		attempts += 1
		new_x_coordinate = randi() % (int(rightMarker.global_position.x) - int(leftMarker.global_position.x)) + int(leftMarker.global_position.x)
		
		var can_add: bool = true
		for x_coord in previous_spawns:
			if abs(x_coord - new_x_coordinate) < 50:
				can_add = false
				break
		
		if can_add:
			previous_spawns.append(new_x_coordinate)
			break
	
	if attempts == max_attempts:
		print("Failed to find a valid position after maximum attempts")
		if (previous_spawns.size() > 0):
			previous_spawns.remove_at(0);
		return
	
	print(new_x_coordinate)
	var new_y_coordinate = leftMarker.global_position.y
	var new_enemy_position = Vector2(new_x_coordinate, new_y_coordinate)
	var new_enemy_instance: Node2D = possible_spawns[rand_index].instantiate()
	new_enemy_instance.global_position = new_enemy_position
	self.add_child(new_enemy_instance)
	


func _on_decrease_spawn_timer_timeout() -> void:
	Events.decrease_spawn_time.emit();
