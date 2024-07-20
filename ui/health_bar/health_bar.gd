extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.damage_player.connect(_decrease_damage_from_healthbar);
	var player: Player = get_tree().get_first_node_in_group(NodeGroups.player);
	self.max_value = player.player_health;
	self.value = player.player_health;

func _decrease_damage_from_healthbar(damage: int):
	if (self.value - damage <= 0):
		self.value = 0;
	else:
		self.value = self.value - damage;
	
