extends Control


const TEST_LEVEL = preload("uid://c833ybfa81h5s")
const FUNCTIONS = preload("uid://b63ghwich3wj")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(TEST_LEVEL)

func _on_functions_pressed() -> void:
	get_tree().change_scene_to_packed(FUNCTIONS)

func _on_setting_pressed() -> void:
	pass # Replace with function body.

func _on_info_pressed() -> void:
	pass # Replace with function body.
