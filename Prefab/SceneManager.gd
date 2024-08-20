class_name SceneManager
extends Node2D

@onready var player : Player = $Player
@onready var manip : Manip = $Manip
@onready var exit : Exit = $Exit
@onready var gameover : Control = $Camera2D/GameOver
@onready var ambience : AudioStreamPlayer2D = $Ambience

@onready var ded : AudioStreamPlayer2D = $Died

func _ready():
	gameover.visible = false
	gameover.set_process(false)

func finished():
	player.is_enabled = false
	manip.is_enabled = false
	exit.is_enabled = false
	ambience.playing = false
	
func died():
	finished()
	ded.play()
	gameover.set_process(true)
	gameover.visible = true
	
