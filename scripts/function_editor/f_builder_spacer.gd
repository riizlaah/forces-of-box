class_name FBUilderSpacer
extends ColorRect

var parent: FBuilder

func _ready() -> void:
	parent = get_parent()
	color = Color.TRANSPARENT

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	var can = parent._can_drop_data(at_position, data)
	if can: color = Color(1,1,1,0.5)
	else: color = Color(1,0,0,0.5)
	return can

func _drop_data(at_position: Vector2, data: Variant) -> void:
	await parent._drop_data(at_position, data)

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_DRAG_END:
			color = Color.TRANSPARENT
