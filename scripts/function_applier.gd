class_name FunctionApplier
extends Node2D

const MAX_VELO_LENGTH := 100_000

var character: CharacterBody2D
var v_applied := false

func _ready() -> void:
	character = get_parent()

func apply_funcs() -> void:
	if v_applied:
		character.velocity = modify_velocity(character.velocity).limit_length(MAX_VELO_LENGTH)
		print(character.velocity)

func modify_velocity(v: Vector2) -> Vector2:
	return v * 1.5
