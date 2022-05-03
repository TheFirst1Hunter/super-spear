extends KinematicBody

export var speed:float = 10
export var max_speed:float = 100
export var mouse_sensitivity:float = 1

var movement_direction:Vector3
var spear_path:PackedScene = load("res://entites/spear.tscn")

onready var head:Spatial = $head
onready var muzzle:Position3D = $head/muzzle
onready var hand:Position3D = $hand/hand
onready var ray_cast:RayCast=$head/RayCast

func _ready():
	pass

func _input(event:InputEvent):
	if not event is InputEventKey and not event is InputEventMouseMotion:
		return
	
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-89), deg2rad(89))
	
	
	if event.is_action_pressed("forward"):
		movement_direction=-transform.basis.z
		speed = max(speed+1,max_speed)
	
	if event.is_action_pressed("backward"):
		movement_direction=transform.basis.z
		speed = max(speed+1,max_speed)
	
	if event.is_action_pressed("right"):
		movement_direction=transform.basis.x
		speed = max(speed+1,max_speed)
	
	if event.is_action_pressed("left"):
		movement_direction=-transform.basis.x
		speed = max(speed+1,max_speed)
	
	if event.is_action_pressed("ui_accept"):
		shoot()


func _physics_process(delta:float):
#	movement_direction.y=-0.5
	move_and_slide(movement_direction*speed)


func shoot():
	var spear = spear_path.instance()
		
#	spear.start(hand.global_transform,muzzle.global_transform.origin)
		
#	if(ray_cast.is_colliding()):
#		spear.start(hand.global_transform,ray_cast.get_collision_point())
		
	add_child(spear)
	spear.global_transform=hand.global_transform
	spear.look_at(muzzle.global_transform.origin,Vector3.UP)
	
