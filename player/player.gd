class_name Player
extends CharacterBody2D

@export var speed: int = 200;
@export var player_collision_damage: float = 20;

@onready var cannon: Node = get_node('%Cannon');

var bullet_scene: PackedScene = preload("res://bullet/bullet.tscn");

var max_fire_delay: float = 0.08;  
var fire_delay: float = 0;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fire_delay = max_fire_delay;

func _process(delta: float) -> void :
	if (Input.is_action_pressed("ui_select")):
		_fire_weapon(delta);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	self.velocity = Input.get_vector("ui_left","ui_right","ui_up","ui_down").normalized() * speed;
	self.move_and_slide();

func _fire_weapon(delta: float):
	if (fire_delay < 0):
		var bullet_instance: Bullet = bullet_scene.instantiate();
		bullet_instance.global_position = self.global_position - Vector2(0, 50);
		cannon.add_child(bullet_instance);
		fire_delay = max_fire_delay;
	else:
		fire_delay -= 1.0 * delta;
