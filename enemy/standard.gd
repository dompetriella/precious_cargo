class_name Standard
extends Node2D

@export var score: int = 10;
@export var speed: float = 90;

func _process(delta: float) -> void:
	_move(delta);

func _move(delta: float):
	self.global_position.y += speed * delta
