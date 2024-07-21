class_name Ufo
extends Node2D

@export var score: int = 10;
@export var speed: float = 90;
@export var collision_damage: int = 25;

func _process(delta: float) -> void:
	_move(delta);

func _move(delta: float):
	self.global_position.y += speed * delta
