extends ProgressBar

@onready var healing_timer: Timer = get_node("%HealingTimer");

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.damage_player.connect(_decrease_damage_from_healthbar);
	Events.toggle_engineer_o2.connect(_toggle_healing_timer);
	var player: Player = get_tree().get_first_node_in_group(NodeGroups.player);
	self.max_value = player.player_health;
	self.value = player.player_health;

func _decrease_damage_from_healthbar(damage: int):
	if (self.value - damage <= 0):
		self.value = 0;
	else:
		self.value = self.value - damage;

func _toggle_healing_timer(connection: bool):
	if (connection):
		healing_timer.start();
	else:
		healing_timer.stop();
		
func _on_healing_timer_timeout() -> void:
	self.value += 1;
