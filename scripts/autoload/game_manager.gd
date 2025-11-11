extends Node

func fade(parent: Control, del_node := false, from := Color(0,0,0,0), to := Color.BLACK, duration := 0.25, freeze_duration := 0.25):
	var cr := ColorRect.new()
	cr.size = parent.get_viewport_rect().size
	cr.color = from
	parent.add_child(cr)
	var tween := cr.create_tween()
	tween.tween_property(cr, "color", to, duration)
	await get_tree().create_timer(duration + freeze_duration).timeout
	if del_node: cr.queue_free()
