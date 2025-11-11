class_name FBUilderSpacer
extends Control

var parent: FBuilder

func _ready() -> void:
	parent = get_parent()

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return parent._can_drop_data(at_position, data)

func _drop_data(at_position: Vector2, data: Variant) -> void:
	await parent._drop_data(at_position, data)
