class_name Player
extends CharacterBody2D

@export_category("Player Properties")
@export var speed: int = 200;
@export var player_collision_damage: float = 20;
@export var player_health: int = 200;

@export_category("Ship Properties")
@export var player_energy_maximium: int = 2000;
@export var player_heat_capacity: int = 200;
@export var player_heat_per_shot: int = 1;
@export var player_energy_per_shot: int = 1;
@export var player_heat_dissapation: int = 1;

@export_category("Connection Properties")
@export var heatsink_improvement_rate: int = 10;
@export var connection_thruster_movement_multiplier: float = 2.5;
@export var shield_damage_reduction_percentage: int = 65;
@export var powershot_cooldown_rate_reduction: int = 50;
@export var powershot_power_multiplier: float = 2.0;

@export_category("Human Connection Properties")
@export var human_oxygen_tick: int = 1;
@export var human_engineer_o2_maximum: int = 100;
@export var human_passenger_o2_maximum: int = 100;


@onready var cannon: Node = get_node('%Cannon');

var bullet_scene: PackedScene = preload("res://bullet/bullet.tscn");

var max_fire_delay: float = 0.08;  
var fire_delay: float = 0;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fire_delay = max_fire_delay;

func _process(delta: float) -> void :
	if (Input.is_action_pressed("ui_shoot")):
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
		Events.change_energy_level.emit(-player_energy_per_shot);
		Events.change_heat_amount.emit(player_heat_per_shot);
	else:
		fire_delay -= 1.0 * delta;
