class_name FBuilder
extends HBoxContainer

@onready var toolbar: FunctionToolbar = $"../../../../../Toolbar"
@onready var spacer: FBUilderSpacer = $Spacer

var curr_formula := ""

func _ready() -> void:
	update_formula()

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if data is not MathDisplayLabel: return false
	if data.type == MathDisplayLabel.Type.OPERATOR and toolbar.curr_operator == toolbar.max_operator: return false
	if !validate_syntax(data.interpreted_str): return false
	return true

func _drop_data(at_position: Vector2, data: Variant) -> void:
	if data is MathDisplayLabel:
		spacer.hide()
		if curr_formula[-1] in ["+", "-"]:
			handle_plus_minus(data)
			update_formula()
			spacer.show()
			return
		if data.type == MathDisplayLabel.Type.OPERATOR: toolbar.curr_operator += 1
		add_child(data)
		await get_tree().create_timer(0.1).timeout
		move_child(spacer, get_child_count() - 1)
		spacer.show()
		update_formula()

func get_formula_as_text() -> String:
	var text := ""
	for node in get_children():
		if node is MathDisplayLabel: text += node.interpreted_str
	return text

func validate_syntax(new_char: String):
	const operator := ["+", "-", "*", "/"]
	var last_char := get_formula_as_text()[-1]
	print(last_char, new_char)
	if last_char in ["+", "-"] and new_char in ["+", "-"]: return true
	if last_char in operator and new_char in operator: return false
	return true

func handle_plus_minus(mdl: MathDisplayLabel):
	var last_char := get_formula_as_text()[-1]
	if last_char not in ["-", "+"]: return
	var new_char := mdl.interpreted_str
	get_child(-2).interpreted_str = "-" if (last_char == "+" and new_char == "-") or (last_char == "-" and new_char == "+") else "+"
	get_child(-2).displayed_str = "-" if (last_char == "+" and new_char == "-") or (last_char == "-" and new_char == "+") else "+"

func update_formula(): curr_formula = get_formula_as_text()
