class_name MathDisplayLabel
extends Label

@export var displayed_str := "+":
	set(c):
		displayed_str = c
		text = c
@export var interpreted_str := "+"
enum Type {CONSTANT, VARIABLE, OPERATOR, OTHER}
@export var type: Type = Type.CONSTANT

func _ready() -> void:
	text = displayed_str
	theme = preload("uid://cdfoekad7tsrx")
	add_theme_font_size_override("font_size", 48)

var last_call := 0
func _input(event: InputEvent) -> void:
	if interpreted_str in ["."]: return
	if event is not InputEventMouseButton and event is not InputEventScreenTouch: return
	if !get_global_rect().has_point(event.position): return
	var curr_ms := Time.get_ticks_msec()
	if !event.pressed: return
	if (curr_ms - last_call) < 1000: return
	last_call = curr_ms
	get_parent().popup_delete(self) # parent = FBuilder
	get_viewport().set_input_as_handled()

func _draw() -> void:
	pass#draw_rect()
