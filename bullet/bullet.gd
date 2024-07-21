class_name Bullet
extends Area2D

@export var speed: int = 650;
@export var bullet_damage: float = 5.0;
@export var bullet_angle: float = 270;

func _process(delta: float) -> void:
	self.global_position.y -= speed * delta;

func _on_area_entered(area: Area2D) -> void:
	if (area.is_in_group(NodeGroups.enemy)):
		self.queue_free();


func _on_body_entered(body: Node2D) -> void:
	if (body is StaticBody2D):
		await get_tree().create_timer(3).timeout;
		self.queue_free();
