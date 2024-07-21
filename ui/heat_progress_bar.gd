extends ProgressBar

var heat_dissapation: int = 0;
var max_heat_value: int = 0;
@onready var heat_dissapation_timer: Timer = get_node("%HeatDissapationTimer");

func _ready() -> void:
	Events.change_heat_amount.connect(_change_heat_amount);
	var player: Player = get_tree().get_first_node_in_group(NodeGroups.player);
	max_heat_value = player.player_heat_capacity;
	self.max_value = max_heat_value;
	heat_dissapation = player.player_heat_dissapation;
	self.add_theme_color_override("fill", Globals.good_blue);

func _process(delta: float) -> void:
	var player: Player = get_tree().get_first_node_in_group(NodeGroups.player);
	heat_dissapation = player.player_heat_dissapation;
	if (self.value >= max_heat_value):
		Events.player_has_died.emit("Engines overheated");

func _change_heat_amount(heat_amount: int):
	if (self.value + heat_amount <= 0):
		self.value = 0;
	else:
		self.value = self.value + heat_amount;


func _on_heat_dissapation_timer_timeout() -> void:
	Events.change_heat_amount.emit(-heat_dissapation);
