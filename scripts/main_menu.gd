extends Control



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await GameManager.fade(self, true, Color.BLACK, Color(0,0,0,0))

func _on_play_pressed() -> void:
	await GameManager.fade(self)
	get_tree().change_scene_to_file("res://scenes/test_level.tscn")

func _on_functions_pressed() -> void:
	await GameManager.fade(self)

	get_tree().change_scene_to_file("res://scenes/functions.tscn")

func _on_setting_pressed() -> void:
	pass # Replace with function body.

func _on_info_pressed() -> void:
	pass # Replace with function body.
