extends Control


const TEST_LEVEL = preload("res://scenes/test_level.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(TEST_LEVEL)


func _on_functions_pressed() -> void:
	pass # Replace with function body.


func _on_setting_pressed() -> void:
	pass # Replace with function body.


func _on_info_pressed() -> void:
	pass # Replace with function body.
