extends Node

@export var cannon_tip_offset: Vector2;
@export var cannon_type: Enums.CannonType;
@export var bullet_speed: int = 200;
@export var max_fire_delay: float = 0.08;

var player_bullet: PackedScene;
var enemy_bullet: PackedScene;
var fire_delay: float = 0;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_bullet = load("res://bullet/bullet.tscn");
	enemy_bullet = load("res://enemy_bullet/enemy_bullet.tscn");
	fire_delay = max_fire_delay;

func _process(delta: float) -> void:
	var cannon_position: Vector2 = get_parent().global_position + cannon_tip_offset;
	_fire_weapon(delta, cannon_position);

func _fire_weapon(delta: float, cannon_position: Vector2):
	if (fire_delay < 0):
		match (cannon_type):
			Enums.CannonType.PLAYER:
				_player_fire(delta);
			Enums.CannonType.NONE:
				print("NONE, FOLLOWING");
			Enums.CannonType.DOWNAIM:
				_fire_downaim(delta, cannon_position);
			_:
				print('other');

		fire_delay = max_fire_delay;
	else:
		fire_delay -= 1.0 * delta;

func _player_fire(delta: float):
	pass;

func _fire_downaim(delta: float, cannon_position: Vector2):
	var bullet_instance: EnemyBullet = enemy_bullet.instantiate();
	bullet_instance.bullet_angle = 90;
	bullet_instance.speed = bullet_speed;
	bullet_instance.global_position = cannon_position;
	self.add_child(bullet_instance);