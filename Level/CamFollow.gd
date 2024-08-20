extends Camera2D

@export var follow : Node2D
@export var move_axis : Vector2

@export var max_pos : Node2D
@export var min_pos : Node2D


func _process(delta):
	if !follow:
		return
	if move_axis.x != 0:
		global_position.x = (follow.global_position * move_axis).x
		
	if move_axis.y != 0:
		global_position.y = (follow.global_position * move_axis).y
		
		
	if max_pos && min_pos:
		if move_axis.y != 0:
			global_position.y = max(max_pos.global_position.y, global_position.y)
			global_position.y = min(min_pos.global_position.y, global_position.y)
		if move_axis.x != 0:
			global_position.x = max(max_pos.global_position.x, global_position.x)
			global_position.x = min(min_pos.global_position.x, global_position.x)
