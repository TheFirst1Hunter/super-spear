extends KinematicBody

export var speed:float = 40
export var max_speed:float = 20
export var mouse_sensitivity:float = 0.5
const ACCEL_DEFAULT = 15
const ACCEL_AIR = 1
onready var accel = ACCEL_DEFAULT
var gravity = 11
var jump = 5

var movement_direction:Vector3
var spear_path:PackedScene = load("res://entites/spear.tscn")

onready var head:Spatial = $head
onready var muzzle:Position3D = $head/muzzle
onready var hand:Position3D = $hand/hand
onready var ray_cast:RayCast=$head/RayCast
onready var campivot = $head/Camera
onready var mesh = $MeshInstance


var cam_accel = 40
var mouse_sense = 0.1
var snap

var angular_velocity = 30

var direction = Vector3()
var velocity = Vector3()
var gravity_vec = Vector3()
var movement = Vector3()


func _ready():
	#hides the cursor
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	#mesh no longer inherits rotation of parent, allowing it to rotate freely
	#mesh.set_as_toplevel(true)
	
func _input(event):
	#get mouse input for camera rotation
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sense))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sense))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-89), deg2rad(89))
	
	if Input.is_action_just_pressed("fire"):
		shoot()

func _process(delta):
	pass
func _physics_process(delta):
	#get keyboard input
	direction = Vector3.ZERO
	var h_rot = global_transform.basis.get_euler().y
	var f_input = Input.get_action_strength("backward") - Input.get_action_strength("forward")
	var h_input = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction = Vector3(h_input, 0, f_input).rotated(Vector3.UP, h_rot).normalized()
	
	#jumping and gravity
#	if is_on_floor():
#		snap = -get_floor_normal()
#		accel = ACCEL_DEFAULT
#		gravity_vec = Vector3.ZERO
#	else:
#		snap = Vector3.DOWN
#		accel = ACCEL_AIR
#		gravity_vec += Vector3.DOWN * gravity * delta
#
#	if Input.is_action_just_pressed("jump") and is_on_floor():
#		snap = Vector3.ZERO
#		gravity_vec = Vector3.UP * jump
	
	#make it move
	velocity = velocity.linear_interpolate(direction * speed, accel * delta)
	#dash
	if Input.is_action_just_pressed("dash"):
		velocity = velocity.linear_interpolate(direction * speed * 4, accel * delta * 15)
	movement = velocity + gravity_vec
	#the jump wont work unless we change to move&slide with snap
	move_and_slide(movement, Vector3.UP)



func shoot():
	var spear = spear_path.instance()
		
#	spear.start(hand.global_transform,muzzle.global_transform.origin)
		
#	if(ray_cast.is_colliding()):
#		spear.start(hand.global_transform,ray_cast.get_collision_point())
		
	add_child(spear)
	spear.global_transform=hand.global_transform
	spear.look_at(muzzle.global_transform.origin,Vector3.UP)
	
