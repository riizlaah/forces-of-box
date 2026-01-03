class_name MathEditorComp
extends PanelContainer

@export var displayed_str := "+"
@export var interpreted_str := "+"
@export var desc := "Add"
@export var type := MathDisplayLabel.Type.OPERATOR

@onready var icon_n: Label = $Vbox/Icon
@onready var desc_n: Label = $Vbox/Desc


func _ready() -> void:
	icon_n.text = displayed_str
	desc_n.text = desc

func _get_drag_data(_pos: Vector2) -> Variant:
	var mlb = MathDisplayLabel.new()
	mlb.displayed_str = displayed_str
	mlb.interpreted_str = interpreted_str
	mlb.type = type
	set_drag_preview(mlb.duplicate())
	mlb.drag_preview = false
	return mlb
