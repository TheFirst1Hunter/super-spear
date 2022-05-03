extends Area

var speed:int=1

var is_picked:bool=true

var collision_point:Vector3

func start(_transform:Transform,starting_position:Vector3)->void:
	collision_point=starting_position
	global_transform=_transform
#	look_at(collision_point,Vector3.UP)

func _ready():
	set_as_toplevel(true)

func _process(delta:float)->void:
#	look_at(collision_point,Vector3.UP)
	transform.origin-=transform.basis.z*speed


func _on_spear_area_entered(area:Area):
	print("d")
	
	speed=0


func _on_spear_body_entered(body:PhysicsBody):
	print("d")
	speed=0
