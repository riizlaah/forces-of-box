class_name FunctionDisplay
extends HBoxContainer

func _get_drag_data(at_position: Vector2) -> Variant:
	set_drag_preview(duplicate())
	modulate = Color("ffffff96")
	return str("f_" + name)
