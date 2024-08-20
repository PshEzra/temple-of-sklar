class_name Manip
extends Node2D

var is_enabled : bool = true

@export var ori : Node2D
@onready var tile : TileMap = $Tile
var is_transforming : bool = false
var max_manip : float = 20

var original_origin : Vector2 = Vector2()

func _physics_process(delta):
	if !is_enabled:
		return
		
	if Input.is_action_just_pressed("transform"):
		is_transforming = !is_transforming
		original_origin = global_position
		if is_transforming && ori:
			global_position = ori.global_position
			tile.global_position += original_origin - global_position
		
	if !is_transforming:
		pass
		return
		
	change_shape()
		
func change_shape():
	if !ori:
		return
	
	var change_scale = Input.get_axis("jump", "down")
	var change_rot = Input.get_axis("left", "right")
	
	var change_vec = Vector2(0.1,0.1) * change_scale * 0.1
	
	if abs(scale.x) <= 0.05:
		tile.tile_set.set_physics_layer_collision_layer(0, false)
		tile.tile_set.set_physics_layer_collision_mask(0, false)
	else:
		tile.tile_set.set_physics_layer_collision_layer(0, true)
		tile.tile_set.set_physics_layer_collision_mask(0, true)

	rotate(change_rot / 100)
	scale += change_vec
	
	scale.x = min(max(scale.x, 0.1), 3)
	scale.y = min(max(scale.y,0.1), 3)
