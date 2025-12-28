extends TextureRect

@onready var del_btn: Button = $Del


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

var last_call := 0
func _input(event: InputEvent) -> void:
	if del_btn.get_global_rect().has_point(get_global_mouse_position()): return
	if event is not InputEventMouseButton and event is not InputEventScreenTouch: return
	var curr_ms := Time.get_ticks_msec()
	if !event.pressed: return
	if (curr_ms - last_call) < 500: return
	last_call = curr_ms
	del_btn.hide()
	await get_tree().process_frame
	print(del_btn.visible)
