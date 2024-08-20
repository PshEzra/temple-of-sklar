extends Control

@onready var main_menu : Panel = $MainMenu
@onready var level_select : Panel = $LevelSelect

func _ready():
	level_select.set_process(false)
	level_select.visible = false
	
	main_menu.set_process(true)
	main_menu.visible = true
	
func activate_level_select():
	level_select.set_process(true)
	level_select.visible = true
	
	main_menu.set_process(false)
	main_menu.visible = false


func _on_button_pressed():
	activate_level_select()
	pass # Replace with function body.
