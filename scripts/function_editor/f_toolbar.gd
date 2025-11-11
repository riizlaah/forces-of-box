class_name FunctionToolbar
extends HBoxContainer

const MATH_EDITOR_COMP = preload("uid://ckxvog3ity17k")
const BASE_MATH_COMPS := [
	{
		"display": "+",
		"interpreted": "+",
		"desc": "Add",
		"type": MathDisplayLabel.Type.OPERATOR
	},
	{
		"display": "-",
		"interpreted": "-",
		"desc": "Subtract",
		"type": MathDisplayLabel.Type.OPERATOR
	},
	{
		"display": "×",
		"interpreted": "*",
		"desc": "Multiply",
		"type": MathDisplayLabel.Type.OPERATOR
	},
	{
		"display": "/",
		"interpreted": "/",
		"desc": "Subdivide",
		"type": MathDisplayLabel.Type.OPERATOR
	},
	{
		"display": "0",
		"interpreted": "0",
		"desc": "Zero",
		"type": MathDisplayLabel.Type.CONSTANT
	},
	{
		"display": "1",
		"interpreted": "1",
		"desc": "One",
		"type": MathDisplayLabel.Type.CONSTANT
	},
	{
		"display": "2",
		"interpreted": "2",
		"desc": "Two",
		"type": MathDisplayLabel.Type.CONSTANT
	},
	{
		"display": "3",
		"interpreted": "3",
		"desc": "Three",
		"type": MathDisplayLabel.Type.CONSTANT
	},
	{
		"display": "4",
		"interpreted": "4",
		"desc": "Four",
		"type": MathDisplayLabel.Type.CONSTANT
	},
	{
		"display": "5",
		"interpreted": "5",
		"desc": "Five",
		"type": MathDisplayLabel.Type.CONSTANT
	},
	{
		"display": "6",
		"interpreted": "6",
		"desc": "Six",
		"type": MathDisplayLabel.Type.CONSTANT
	},
	{
		"display": "7",
		"interpreted": "7",
		"desc": "Seven",
		"type": MathDisplayLabel.Type.CONSTANT
	},
	{
		"display": "8",
		"interpreted": "8",
		"desc": "Eight",
		"type": MathDisplayLabel.Type.CONSTANT
	},
	{
		"display": "9",
		"interpreted": "9",
		"desc": "Nine",
		"type": MathDisplayLabel.Type.CONSTANT
	},
	{
		"display": "x",
		"interpreted": "x",
		"desc": "X Variable",
		"type": MathDisplayLabel.Type.VARIABLE
	},
	{
		"display": "y",
		"interpreted": "y",
		"desc": "Y Variable",
		"type": MathDisplayLabel.Type.VARIABLE
	},
]

@onready var math_comps_node: HBoxContainer = $SCont/MathComps
@onready var op_count: Label = $Vbox/OpCount
@onready var toggle_search: TextureButton = $Vbox/Hbox/ToggleSearch
@onready var search_input: LineEdit = $Vbox/Hbox/SearchInput


var max_operator := 1
var curr_operator := 0:
	set(n):
		curr_operator = n
		if !is_instance_valid(op_count): return
		op_count.text = "OP Count %d / %d" % [curr_operator, max_operator]

func _ready() -> void:
	for item in BASE_MATH_COMPS: create_math_component(item)

func create_math_component(data: Dictionary):
	var mec: MathEditorComp = MATH_EDITOR_COMP.instantiate()
	mec.displayed_str = data.display
	mec.interpreted_str = data.interpreted
	mec.desc = data.desc
	mec.type = data.type
	math_comps_node.add_child(mec)

func _on_toggle_search_pressed() -> void:
	search_input.visible = !search_input.visible
	toggle_search.flip_h = search_input.visible

func _on_search_input_text_changed(new_text: String) -> void:
	if new_text.is_empty():
		for item in math_comps_node.get_children(): item.show()
		return
	for item in math_comps_node.get_children():
		if !item.desc.containsn(new_text):
			item.hide()
			continue
		item.show()
