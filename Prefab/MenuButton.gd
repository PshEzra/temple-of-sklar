extends Button

@export var main_menu : PackedScene

func _on_pressed():
	get_tree().change_scene_to_file("res://Level/main_menu.tscn")


