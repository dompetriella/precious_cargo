class_name EnemyBullet
extends Node2D

@export var enemy_bullet_damage: int = 5;
@export var bullet_angle: float = 90;
@export var speed: float = 500;

var starting_position: Vector2;


func _on_body_entered(body: Node2D) -> void:
	if (body is Player):
		Events.damage_player.emit(enemy_bullet_damage);
		Events.play_sfx_player.emit("res://assets/audio/player_take_damage.ogg");
		self.queue_free();


func _process(delta: float) -> void:
	var angle_in_radians = deg_to_rad(bullet_angle);
	var bullet_direction: Vector2 = Vector2(cos(angle_in_radians), sin(angle_in_radians)).normalized();
	self.global_position += bullet_direction * speed * delta;


func _on_area_entered(area: Area2D) -> void:
	if (area.name == "DespawnZone"):
		await get_tree().create_timer(3).timeout;
		self.queue_free();
