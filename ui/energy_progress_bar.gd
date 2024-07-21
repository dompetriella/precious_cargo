extends ProgressBar

var max_energy_value: int = 0;

func _ready() -> void:
	Events.change_energy_level.connect(_change_energy_level);
	var player: Player = get_tree().get_first_node_in_group(NodeGroups.player);
	max_energy_value = player.player_energy_maximium;
	self.max_value = max_energy_value;
	self.value = max_energy_value;
	self.add_theme_color_override("fill", Globals.good_blue);


func _change_energy_level(energy_amount: int):
	if (self.value + energy_amount >= max_energy_value):
		self.value = max_energy_value;
	if (self.value - energy_amount <= 0):
		Events.player_has_died.emit("Ship ran out of energy");
	else:
		self.value += energy_amount;
	
