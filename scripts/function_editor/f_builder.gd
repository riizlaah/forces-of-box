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
		var last_char = curr_formula[-1]
		if last_char in ["+", "-"] and data.interpreted_str in ["+", "-"]:
			handle_plus_minus(data)
			update_formula()
			spacer.show()
			return
		if handle_zero(data): return
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
	if last_char in ["+", "-"] and new_char in ["+", "-"]: return true
	if last_char in operator and new_char in operator: return false
	if float_not_valid(new_char): return false
	if num_not_valid(new_char): return false
	return true

func num_not_valid(new_char: String):
	var formula = get_formula_as_text() + new_char
	var res = RegEx.create_from_string(r"[a-z]\d|[a-z][a-z]|\d[a-z]").search(formula)
	if res: return true
	return false

func float_not_valid(new_char: String):
	var formula = get_formula_as_text() + new_char
	var res = RegEx.create_from_string(r"\.\.|\d+\.\d+\.|\D+\.|\.\D").search(formula)
	if !res: return false
	return true

func handle_plus_minus(mdl: MathDisplayLabel):
	var last_char := get_formula_as_text()[-1]
	var new_char := mdl.interpreted_str
	#if last_char not in ["-", "+"] or new_char not in ["-", "+"]: return
	get_child(-2).interpreted_str = "-" if (last_char == "+" and new_char == "-") or (last_char == "-" and new_char == "+") else "+"
	get_child(-2).displayed_str = "-" if (last_char == "+" and new_char == "-") or (last_char == "-" and new_char == "+") else "+"

func handle_zero(data: MathDisplayLabel):
	var comp = get_last_comp()
	print(comp)
	if comp == "0" and data.type == MathDisplayLabel.Type.CONSTANT:
		get_child(-2).interpreted_str = data.interpreted_str
		get_child(-2).displayed_str = data.displayed_str
		update_formula()
		spacer.show()
		return true
	return false

func update_formula(): curr_formula = get_formula_as_text()

func get_last_comp():
	var last_idx = curr_formula.get_slice_count("+") - 1
	var comp = curr_formula.get_slice("+", last_idx)
	for op in ["-", "*", "/"]:
		last_idx = comp.get_slice_count(op) - 1
		comp = comp.get_slice(op, last_idx)
	return comp
