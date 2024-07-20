class_name Bullet
extends Area2D

@export var speed: int = 650;
@export var bullet_damage: float = 5.0;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.global_position.y -= speed * delta;


func _on_body_entered(body: Node2D) -> void:
	if (body.is_in_group(NodeGroups.enemy)):
		self.queue_free();


func _on_area_entered(area: Area2D) -> void:
	if (area.is_in_group(NodeGroups.player)):
		pass;
