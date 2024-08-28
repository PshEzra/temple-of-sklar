extends Control

@export var next_scene : PackedScene

func _on_button_pressed():
	if !next_scene:
		get_tree().reload_current_scene()
		return
	get_tree().change_scene_to_packed(next_scene)
