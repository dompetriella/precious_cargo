class_name Player
extends CharacterBody2D

@export_category("Player Properties")
@export var speed: int = 200;
@export var player_collision_damage: float = 20;
@export var player_health: int = 200;

@export_category("Ship Properties")
@export var player_energy_maximium: int = 2000;
@export var max_fire_delay: float = 0.10;
@export var player_heat_capacity: int = 200;
@export var player_heat_per_shot: int = 1;
@export var player_energy_per_shot: int = 1;
@export var player_heat_dissapation: int = 1;

@export_category("Energy Requirements")
@export var thruster_energy: int = 2;
@export var powershot_energy: int = 3;
@export var engineer_o2_energy: int = 4;
@export var passenger_o2_energy: int = 3;
@export var recharge_rate: int = 20;

@export_category("Connection Properties")
@export var heatsink_improvement_rate: int = 10;
@export var connection_thruster_movement_multiplier: float = 2.5;
@export var shield_damage_reduction_percentage: int = 65;
@export var powershot_cooldown_rate_reduction: float = 0.5;
@export var powershot_power_multiplier: float = 2.0;

@export_category("Human Connection Properties")
@export var human_oxygen_tick: int = 1;
@export var human_engineer_o2_maximum: int = 100;
@export var human_passenger_o2_maximum: int = 100;
@export var human_engineer_base_repair_rate: float = 1;
@export var human_passenger_base_point_increase: float = 1;

@onready var cannon: Node = get_node('%Cannon');
@onready var energy_sap: Timer = get_node("%EnergySapper");
@onready var energy_recharge: Timer = get_node("%EnergyRecharge");
@onready var particles: GPUParticles2D = get_node("GPUParticles2D");

var thrust_connected = false;
var powershot_connected = false;
var engineer_o2_connected = false;
var passenger_o2_connected = false;

var bullet_scene: PackedScene = preload("res://bullet/bullet.tscn");

var fire_delay: float = 0;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fire_delay = max_fire_delay;
	
	# connections
	Events.toggle_thrusters.connect(
		func(connection):
			thrust_connected = connection; 
			if (connection):
				particles.amount = 100;
			else:
				particles.amount = 30;
	);
	Events.toggle_powershot.connect(
		func(connection):
		powershot_connected = connection;
	);
	
	Events.toggle_engineer_o2.connect(
		func(connection):
		engineer_o2_connected = connection;
	);
	
	Events.toggle_passenger_o2.connect(
		func(connection):
		passenger_o2_connected = connection;
	);

func _process(delta: float) -> void :
	if (Input.is_action_pressed("ui_shoot")):
		_fire_weapon(delta);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var thruster_multiplier: float = 1;
	if (thrust_connected):
		thruster_multiplier = connection_thruster_movement_multiplier;
	self.velocity = Input.get_vector("ui_left","ui_right","ui_up","ui_down").normalized() * (speed * thruster_multiplier);
	self.move_and_slide();

func _fire_weapon(delta: float):
	if (fire_delay < 0):
		var bullet_instance: Bullet = bullet_scene.instantiate();
		bullet_instance.global_position = self.global_position - Vector2(0, 50);
		cannon.add_child(bullet_instance);
		var max_fire_delay_reduction: float = 1;
		if (powershot_connected):
			max_fire_delay_reduction = powershot_cooldown_rate_reduction;
		fire_delay = max_fire_delay * max_fire_delay_reduction;
		Events.play_sfx_player.emit("res://assets/audio/player_laser.ogg");
		Events.change_heat_amount.emit(player_heat_per_shot);
	else:
		fire_delay -= 1.0 * delta;


func _on_energy_sapper_timeout() -> void:
	var energy_total: int = 0;
	if (thrust_connected):
		energy_total += thruster_energy;
	if (powershot_connected):
		energy_total += powershot_energy;
	if (engineer_o2_connected):
		energy_total += engineer_o2_energy;
	if (passenger_o2_connected):
		energy_total += energy_total;
	Events.change_energy_level.emit(-energy_total);


func _on_energy_recharge_timeout() -> void:
	Events.change_energy_level.emit(recharge_rate);
