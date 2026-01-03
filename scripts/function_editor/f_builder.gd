class_name FBuilder
extends HBoxContainer

var toolbar: FunctionToolbar
@onready var spacer: FBUilderSpacer = $Spacer
var del_btn: Button

var curr_formula := ""
var idxs := []


func _ready() -> void:
	toolbar = GameManager.f_toolbar
	update_formula()
	await get_parent().ready
	if get_parent().drag_preview: return
	del_btn.hidden.connect(func():
		idxs = []
		queue_redraw()
	)

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
	if comp == "0" and data.type == MathDisplayLabel.Type.CONSTANT:
		get_child(-2).interpreted_str = data.interpreted_str
		get_child(-2).displayed_str = data.displayed_str
		update_formula()
		spacer.show()
		return true
	return false

func update_formula():
	curr_formula = get_formula_as_text()

func get_last_comp():
	var last_idx = curr_formula.get_slice_count("+") - 1
	var comp = curr_formula.get_slice("+", last_idx)
	for op in ["-", "*", "/"]:
		last_idx = comp.get_slice_count(op) - 1
		comp = comp.get_slice(op, last_idx)
	return comp

# Delete
func popup_delete(start: MathDisplayLabel):
	if get_child_count() == 2: return
	var start_type := start.type
	for i in range(start.get_index(), get_child_count()):
		var child := get_child(i)
		if child is FBUilderSpacer: break
		if start_type == MathDisplayLabel.Type.OPERATOR:
			if child.type == MathDisplayLabel.Type.OPERATOR and i != start.get_index(): break
			idxs.append(i)
		else:
			idxs.append(i)
			if child.type == MathDisplayLabel.Type.OPERATOR: break
	var extras := []
	if start_type != MathDisplayLabel.Type.OPERATOR: for i in range(start.get_index(), 0, -1):
		if get_child(i).type == MathDisplayLabel.Type.OPERATOR: break
		extras.push_front(i)
	idxs = extras + idxs
	if idxs.size() >= get_child_count() - 1:
		del_btn.hide()
		return
	queue_redraw()
	del_btn.global_position = start.global_position - Vector2(0, 40)
	if del_btn.pressed.is_connected(del_idxs): del_btn.pressed.disconnect(del_idxs)
	del_btn.pressed.connect(del_idxs.bind(idxs), CONNECT_ONE_SHOT)
	await get_tree().process_frame
	del_btn.show()

func del_idxs(indexes: Array):
	for i in idxs:
		get_child(i).queue_free()
	idxs = []
	del_btn.hide()
	await get_tree().process_frame
	update_formula()

func _draw() -> void:
	if idxs.is_empty(): 
		return
	var bounds := Rect2()
	var has_bound := false
	for i in idxs:
		var child_rect := Rect2(get_child(i).position, get_child(i).size)
		child_rect.size.x += 5
		child_rect.position.x -= 2.5
		if has_bound:
			bounds = bounds.merge(child_rect)
		else:
			bounds = child_rect
			has_bound = true
	draw_rect(bounds, Color.WHITE, false, 1)
