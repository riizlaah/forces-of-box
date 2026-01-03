extends RichTextLabel

func _get_drag_data(at_position: Vector2) -> Variant:
	return get_parent().get_parent()._get_drag_data(at_position)
