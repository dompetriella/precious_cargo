class_name ToggleConnectionButton
extends Button

var connection_icon: Texture2D;
var connection_type: Enums.ConnectionType;

var slots: Array[Node] = [];
var is_connected: bool = false;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	slots = get_tree().get_nodes_in_group(NodeGroups.connection_slot);
	
	var parent: Control = get_parent();
	connection_icon = parent.icon;
	connection_type = parent.connection_type;
	self.text = "CONNECT \n" + _get_name();

func _on_toggled(toggled_on: bool) -> void:
	if (toggled_on):
		_add_connection_to_slot();
		_toggle_connection(true);
		self.text = "DISCONNECT \n" + _get_name();
	else:
		_disconnect();
		_toggle_connection(false);
		self.text = "CONNECT \n" + _get_name();
		
func _process(delta: float) -> void:
	var buttons: Array[Node] = get_tree().get_nodes_in_group(NodeGroups.toggle_connection_button);
	var amount_connnected: int = 0;
	for button in buttons:
		if (button.is_connected):
			amount_connnected += 1;
	
	if (amount_connnected > 1):
		for button in buttons:
			if (!button.is_connected):
				button.disabled = true;
	else:
		for button in buttons:
			if (!button.is_connected):
				button.disabled = false;

func _disconnect():
	is_connected = false;
	for slot in slots:
		var texture_rect: TextureRect = slot.get_child(0).get_child(0);
		if (texture_rect.texture == connection_icon):
			texture_rect.texture = null;
			return;

func _add_connection_to_slot():
	is_connected = true;
	var texture: TextureRect = TextureRect.new();
	texture.texture = connection_icon;
	texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE;
	texture.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED;
	
	for slot in slots:
		var texture_rect: TextureRect = slot.get_child(0).get_child(0);
		if (texture_rect.texture == null):
			texture_rect.texture = connection_icon;
			return;

func _toggle_connection(connect_status: bool):
	if (connection_type == Enums.ConnectionType.THRUSTERS):
		Events.toggle_thrusters.emit(connect_status)
	elif (connection_type == Enums.ConnectionType.POWERSHOT):
		Events.toggle_powershot.emit(connect_status);
	elif (connection_type == Enums.ConnectionType.ENGINEER):
		Events.toggle_engineer_o2.emit(connect_status);
	elif (connection_type == Enums.ConnectionType.PASSENGER):
		Events.toggle_passenger_o2.emit(connect_status);

func _get_name() -> String:
	if (connection_type == Enums.ConnectionType.HEATSINKS):
		return "HEATSINKS";
	elif (connection_type == Enums.ConnectionType.THRUSTERS):
		return "THRUSTERS";
	elif (connection_type == Enums.ConnectionType.SHIELDS):
		return "SHIELDS";
	elif (connection_type == Enums.ConnectionType.POWERSHOT):
		return "POWERSHOT";
	elif (connection_type == Enums.ConnectionType.ENGINEER):
		return "ENGINEER O2";
	else:
		return "PASSENGER O2";
