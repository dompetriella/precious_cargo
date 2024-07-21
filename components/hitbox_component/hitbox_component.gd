class_name HitboxComponent
extends Node

@export var health_component: HealthComponent;

var powershot_connected = false;
var score_multiplier: float = 1.0;

func _on_ready():
	Events.toggle_powershot.connect(
	func():
		powershot_connected = true;
	)
	Events.send_passenger_bonus.connect(
	func(bonus):
		score_multiplier = bonus;
	)

func _on_area_entered(area: Area2D) -> void:
	if (area is Bullet):
		var player: Player = get_tree().get_first_node_in_group(NodeGroups.player);
		var powershot_multiplier: float = 1;
		if (powershot_connected):
			powershot_multiplier = player.powershot_power_multiplier;
		health_component.take_damage(area.bullet_damage * powershot_multiplier);
		Events.play_sfx.emit("res://assets/audio/enemy_damage.ogg");
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
		Events.increase_game_score.emit(parent.score * score_multiplier);
		get_parent().queue_free();
