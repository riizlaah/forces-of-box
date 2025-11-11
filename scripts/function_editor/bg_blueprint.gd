extends TextureRect

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if data is not String: return false
	if !data.begins_with("f_"): return false
	return true

func _drop_data(at_position: Vector2, data: Variant) -> void:
	if data is String:
		data = data.trim_prefix("f_")
		var node: FunctionDisplay = get_node(data)
		node.position = at_position
		node.modulate = Color.WHITE
