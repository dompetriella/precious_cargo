class_name HealthComponent
extends Node

@export var max_health: float = 10.0;

var health: float;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = max_health;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func take_damage(damage: float):
	health -= damage;
	print(self.name + " took " + str(damage));
	print(str(health) + "/" + str(max_health));
	
	if (health <= 0):
		var score_amount: int = get_parent().score;
		Events.increase_game_score.emit(score_amount);
		get_parent().queue_free();
