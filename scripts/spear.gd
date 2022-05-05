extends Area
class_name Spear

var speed:int=1

var is_picked:bool=true
var is_stuck:bool=false

var collision_point:Vector3=Vector3(0,0,0)

var _transform:Transform

func start(hand_transform:Transform,look_at_position:Vector3)->void:
	collision_point=look_at_position
	global_transform=hand_transform
	_transform=hand_transform
	look_at(collision_point,Vector3.UP)
	is_picked=false

func _ready():
	pass
	# set_as_toplevel(true)

func _process(delta:float)->void:
#	if is_picked:
#		global_transform=_transform
	
	if !is_picked and !is_stuck:
		transform.origin-=transform.basis.z*speed

func pick():
	set_as_toplevel(false)
	is_picked=true
	is_stuck=false
	transform.origin=Vector3(0,0,0)
	rotation_degrees=Vector3(0,0,0)

func throw():
	set_as_toplevel(true)
	is_picked=false
	is_stuck=false

func _on_spear_area_entered(area:Area):
	is_stuck=true


func _on_spear_body_entered(body:PhysicsBody):
	if body is Player:
		return
	is_stuck=true


func _on_PickArea_body_entered(body:PhysicsBody):
	if body is Player:
		var player:Player = body
		if ! is_picked and is_stuck:
			pick()
