extends Button

@export var level : PackedScene

func _on_pressed():
	print("AAA")
	get_tree().change_scene_to_packed(level)
