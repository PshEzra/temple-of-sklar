class_name Player
extends CharacterBody2D

var is_enabled : bool = true
@onready var footstep : AudioStreamPlayer2D = $Footstep
@onready var jump : AudioStreamPlayer2D = $Jump
@onready var rescale : AudioStreamPlayer2D = $Scale
@onready var poweroff : AudioStreamPlayer2D = $PowerOff
@onready var rotate : AudioStreamPlayer2D = $Rotate
@onready var dead_effect : AudioStreamPlayer2D = $Dead
@onready var earthmove : AudioStreamPlayer2D = $Earthmove

var speed : float = 250

var mat : ShaderMaterial
var time : float

@onready var sprite : Node2D = $Sprite
@onready var sprite_main : Sprite2D = $Sprite/Icon
@onready var gem_main : Sprite2D = $Sprite/Gem
@onready var axis_display : Sprite2D = $Axis

var gem_pos : Vector2 = Vector2()

var is_transforming : bool = false

func _ready():
	mat = sprite_main.material
	time = 0
	
	gem_pos = gem_main.position

func _physics_process(delta):
	if !is_enabled:
		return
	
	if Input.is_action_just_pressed("transform"):
		is_transforming = !is_transforming
		if is_transforming:
			rescale.play()
		else:
			poweroff.play()
	
	if is_transforming:
		gem_main.position.y = lerp(gem_main.position.y, -45.0, 0.1)
		sprite.rotation_degrees = lerp(sprite.rotation_degrees, 0.0, 0.1)
		if !axis_display.visible:
			axis_display.visible = true
		
		axis_rotate()
		return
	elif axis_display.visible:
		axis_display.visible = false
		
	move()
	
	for i in range(get_slide_collision_count()):
		if get_slide_collision(i).get_collider().name == "AvoidTile":
			dead()
	
func axis_rotate():
	var change_rot = Input.get_axis("left", "right")
	
	var change_scale = Input.get_axis("down", "jump")
	
	if change_scale != 0 && !earthmove.playing:
		earthmove.play()
	axis_display.rotate(change_rot / 100)
	
	if change_rot != 0 && !rotate.playing:
		rotate.play()
	
func move():
	
	var dir = Input.get_axis("left", "right")
	
	velocity.x = dir * speed
	
	if !is_on_floor():
		velocity.y += 20
		sprite.rotation_degrees = lerp(sprite.rotation_degrees, 0.0, 0.1)
	else:
		sprite.rotation_degrees = lerp(sprite.rotation_degrees, dir * 12, 0.1)
		if dir != 0:
			add_time(0.05)
			if !footstep.playing:
				footstep.play()
		
	if Input.is_action_just_pressed("jump") && is_on_floor() && !is_transforming:
		velocity.y = -500
		jump.play()
	
	if dir != 0:
		sprite.scale.x = dir
		gem_main.position.y = lerp(gem_main.position.y, -45.0, 0.1)
	else:
		time = 0
		mat.set_shader_parameter("time_ext", 0)
		gem_main.position.y = lerp(gem_main.position.y, gem_pos.y, 0.1)
	
	move_and_slide()
	
func add_time(delt):
	time += delt
	mat.set_shader_parameter("time_ext", time)

func dead():
	get_parent().died()
	queue_free()
