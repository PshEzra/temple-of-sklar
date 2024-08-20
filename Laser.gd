extends Node2D

@onready var ray : RayCast2D = $Ray
@onready var beam : Line2D = $Beam

func _ready():
	beam.add_point(global_position)
	beam.add_point(ray.get_collision_point())
	
func _process(delta):
	beam.set_point_position(0, global_position)
	beam.set_point_position(1, ray.get_collision_point())
	
	if ray.get_collider() is Player:
		ray.get_collider().dead()
