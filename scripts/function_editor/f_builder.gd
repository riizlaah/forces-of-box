class_name FBuilder
extends HBoxContainer

@onready var toolbar: FunctionToolbar = $"../../../../../Toolbar"
@onready var spacer: FBUilderSpacer = $Spacer


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if data is not MathDisplayLabel: return false
	if data.type == MathDisplayLabel.Type.OPERATOR and toolbar.curr_operator == toolbar.max_operator: return false
	return true

func _drop_data(at_position: Vector2, data: Variant) -> void:
	if data is MathDisplayLabel:
		spacer.hide()
		if data.type == MathDisplayLabel.Type.OPERATOR: toolbar.curr_operator += 1
		add_child(data)
		await get_tree().create_timer(0.1).timeout
		move_child(spacer, get_child_count() - 1)
		spacer.show()
