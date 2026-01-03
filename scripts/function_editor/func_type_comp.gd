class_name FuncEditorComp
extends PanelContainer

@export var fname := "V.x,(x)"
@export var desc := "X Velocity"

@onready var icon_n: RichTextLabel = $Vbox/Icon
@onready var desc_n: Label = $Vbox/Desc

const F_DISPLAY := preload("uid://bw127lhv5d1f4")

func _ready() -> void:
	icon_n.text = "[font_size=30]%s[/font_size]" % fname.replace('.', '[font_size=20]').replace(',', '[/font_size]')
	desc_n.text = desc

func _get_drag_data(_pos: Vector2) -> Variant:
	var fd = create_fdisplay(fname)
	set_drag_preview(create_fdisplay(fname, true))
	return fd

func create_fdisplay(fname0, drag_preview := false):
	var f_display = F_DISPLAY.instantiate()
	f_display.drag_preview = drag_preview
	f_display.fname = fname0
	return f_display
