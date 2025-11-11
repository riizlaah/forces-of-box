extends Control



func _ready() -> void:
	await GameManager.fade(self, true, Color.BLACK, Color(0,0,0,0))

func _on_close_pressed() -> void:
	await GameManager.fade(self)
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
