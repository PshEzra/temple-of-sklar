extends Button

@export var level : String

func _on_pressed():
	get_tree().change_scene_to_file(level)
