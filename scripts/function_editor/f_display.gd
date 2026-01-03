class_name FunctionDisplay
extends HBoxContainer

var fname := "V.x,(x)":
	set(s):
		fname = s
		display_str = "[font_size=30]%s[/font_size] =" % fname.replace('.', '[font_size=20]').replace(',', '[/font_size]')
var display_str := "[font_size=30]V[font_size=20]x[/font_size](x)[/font_size] ="
@onready var label: RichTextLabel = $Label
var del_btn: Button
var drag_preview := false

func _ready() -> void:
	name = fname.replace('.', '_').replace(',', '-')
	label.text = display_str
	if drag_preview: return
	del_btn = get_parent().get_child(0)
	get_child(1).del_btn = del_btn
	del_btn.hidden.connect(func():
		if del_btn.pressed.is_connected(del): del_btn.pressed.disconnect(del)
	)
	tree_exited.connect(get_parent().update_functions_name)

func _get_drag_data(at_position: Vector2) -> Variant:
	set_drag_preview(duplicate(3))
	modulate = Color("ffffff96")
	return str("f_" + name)

var last_call := 0
func _input(event: InputEvent) -> void:
	if event is not InputEventMouseButton: return
	if !event.pressed or !event.double_click: return
	if !get_global_rect().has_point(get_global_mouse_position()): return
	var curr_ms = Time.get_ticks_msec()
	if (curr_ms - last_call) < 1000: return
	last_call = curr_ms
	del_btn.pressed.connect(del, CONNECT_ONE_SHOT)
	del_btn.global_position = global_position - Vector2(-20, 40)
	del_btn.show()
	get_viewport().set_input_as_handled()

func del():
	queue_free()
	del_btn.hide()
