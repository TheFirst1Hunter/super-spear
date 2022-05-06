extends Area
class_name Spear

var speed:int=1

var is_picked:bool=true
var is_stuck:bool=false

var collision_point:Vector3

var _transform:Transform

func start(hand_transform:Transform,look_at_position:Vector3)->void:
	collision_point=look_at_position
	global_transform=hand_transform
	_transform=hand_transform
	look_at(collision_point,Vector3.UP)
	is_picked=false

func _ready():
	set_as_toplevel(true)

func _process(delta:float)->void:
	if is_picked:
		global_transform=_transform
	
	if !is_picked and !is_stuck:
		transform.origin-=transform.basis.z*speed

func pick():
	global_transform=_transform
	is_picked=true
	is_stuck=false

func _on_spear_area_entered(area:Area):
	is_stuck=true


func _on_spear_body_entered(body:PhysicsBody):
	if body.is_in_group("enemies"):
		print("damaged")
	elif body is Player:
		return
	else:
		is_stuck=true
