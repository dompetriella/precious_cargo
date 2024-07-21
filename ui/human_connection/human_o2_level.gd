extends ProgressBar

var connection_type: Enums.ConnectionType;
var max_o2_capacity: int;
var oxygen_tick_amount: int;
var oxygen_is_on: bool = false;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var human_connection: HumanConnection = get_parent();
	var player: Player = get_tree().get_first_node_in_group(NodeGroups.player);
	connection_type = human_connection.connection_type;
	oxygen_tick_amount = player.human_oxygen_tick;
	if (connection_type == Enums.ConnectionType.ENGINEER):
		Events.toggle_engineer_o2.connect(
			func(connection):
				oxygen_is_on = connection;
		)
		max_o2_capacity = player.human_engineer_o2_maximum;
		self.max_value = max_o2_capacity;
	else:
		Events.toggle_passenger_o2.connect(
			func(connection):
				oxygen_is_on = connection;
		)
		max_o2_capacity = player.human_passenger_o2_maximum;
		self.max_value = max_o2_capacity;
	self.value = max_o2_capacity;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (self.value <= 0):
		Events.player_has_died.emit("Passengers ran out of Oxygen :(");


func _on_oxygen_tick_timeout() -> void:
	if (oxygen_is_on):
		self.value += oxygen_tick_amount * 1.5;
	else:
		self.value -= oxygen_tick_amount;
	Events.send_passenger_bonus.emit(self.value);
