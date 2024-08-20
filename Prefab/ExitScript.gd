class_name  Exit
extends Area2D

var is_enabled : bool = true

@onready var exit_pointer : Node2D = $"Exit Pointer"
var init_pos : Vector2
@export var end_screen : Control

var toggle : bool = false

func _ready():
	init_pos = exit_pointer.position
	exit_pointer.position.y += 40
	exit_pointer.modulate.a = 0
	if end_screen:
		end_screen.set_process(false)
		end_screen.visible = false

func _on_body_entered(body):
	if body is Player:
		toggle = true
		toggle_text(true)

func _on_body_exited(body):
	if body is Player:
		toggle = true
		toggle_text(false)
		
func _process(delta):
	if !is_enabled:
		return
	if Input.is_action_just_pressed("exit") && toggle:
		get_parent().finished()
		if end_screen:
			end_screen.set_process(true)
			end_screen.visible = true
	
func toggle_text(state : bool):
	var inbet : Tween = get_tree().create_tween()
	var pos_inbet : Tween = get_tree().create_tween()
	if state:
		inbet.tween_property(exit_pointer, "modulate", Color(1,1,1,1), 0.5)
		pos_inbet.tween_property(exit_pointer, "position", init_pos, 0.5)
	else:
		inbet.tween_property(exit_pointer, "modulate", Color(1,1,1,0), 0.5)
		pos_inbet.tween_property(exit_pointer, "position", init_pos + Vector2(0, 40), 0.5)
	#if state:
	#	exit_pointer.modulate.a = lerp(exit_pointer.modulate.a, 1.0, 0.1)
	#	exit_pointer.position.y = lerp(exit_pointer.position.y, init_pos.y, 0.1)
	#else:
	#	exit_pointer.modulate.a = lerp(exit_pointer.modulate.a, 0.0, 0.1)
	#	exit_pointer.position.y = lerp(exit_pointer.position.y, init_pos.y + 40, 0.1)
