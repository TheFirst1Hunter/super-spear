extends KinematicBody
class_name Enemy

var path=[]
var path_node=0
var speed=10
onready var theplayer= $"../../player"
onready var nav= get_parent()



func _physics_process(delta)->void:
	if path_node < path.size():
		var direction:Vector3 = (path[path_node]- global_transform.origin)
		if direction.length() < 1:
			path_node+=1
		else:
			move_and_slide(direction.normalized() * speed , Vector3.UP)

func move_to(target_pos)->void:
	path= nav.get_simple_path(global_transform.origin, target_pos)
	path_node=0




func _on_Timer_timeout()->void:
	move_to(theplayer.global_transform.origin)
