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
