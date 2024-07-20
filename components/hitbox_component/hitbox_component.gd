class_name HitboxComponent
extends Node

@export var health_component: HealthComponent;

func _on_area_entered(area: Area2D) -> void:
	if (area is Bullet):
		print("I have been struck!");
		health_component.take_damage(area.bullet_damage);


func _on_body_entered(body: Node2D) -> void:
	if (body is Player):
		health_component.take_damage(body.player_collision_damage);
