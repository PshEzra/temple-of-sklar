extends Node2D

@export var screen: String

func _process(delta):
	if Input.is_action_just_pressed("transform"):
		get_tree().change_scene_to_file(screen)
