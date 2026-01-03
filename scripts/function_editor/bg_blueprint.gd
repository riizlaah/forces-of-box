class_name BlueprintGrid
extends TextureRect

@onready var del_btn: Button = $Del

var functions_name := []

func _ready() -> void:
	update_functions_name()

func _can_drop_data(_pos: Vector2, data: Variant) -> bool:
	if data is FunctionDisplay:
		if data.fname in get_functions_name(): return false
		return true
	if data is not String: return false
	if !data.begins_with("f_"): return false
	return true

func _drop_data(at_position: Vector2, data: Variant) -> void:
	if data is FunctionDisplay:
		data.position = at_position
		add_child(data)
		update_functions_name.call_deferred()
	if data is String:
		data = data.trim_prefix("f_")
		var node: FunctionDisplay = get_node(data)
		node.position = at_position
		node.modulate = Color.WHITE

func get_functions_name():
	return functions_name

func update_functions_name():
	functions_name = get_children().filter(func(n): return n is FunctionDisplay).map(func(n): return n.fname)

var last_call := 0
func _gui_input(event: InputEvent) -> void:
	if del_btn.get_global_rect().has_point(get_global_mouse_position()): return
	if event is not InputEventMouseButton and event is not InputEventScreenTouch: return
	var curr_ms := Time.get_ticks_msec()
	if !event.pressed: return
	if (curr_ms - last_call) < 500: return
	last_call = curr_ms
	del_btn.hide()
	await get_tree().process_frame
