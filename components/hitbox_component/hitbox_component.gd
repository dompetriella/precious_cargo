class_name HitboxComponent
extends Node

@export var health_component: HealthComponent;

func _on_area_entered(area: Area2D) -> void:
	if (area is Bullet):
		health_component.take_damage(area.bullet_damage);
	if (area.name == "DespawnZone"):
		await get_tree().create_timer(5).timeout;
		get_parent().queue_free();
	
func _on_body_entered(body: Node2D) -> void:
	var parent: Node2D = get_parent();
	var collide_damage = 25;
	if (parent.collision_damage != null):
		collide_damage = parent.collision_damage;
	if (body is Player):
		Events.damage_player.emit(collide_damage);
		Events.increase_game_score.emit(parent.score);
		get_parent().queue_free();
