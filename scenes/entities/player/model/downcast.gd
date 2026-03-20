extends RayCast3D
class_name Downcast

@onready var root_attachment = $"../Root"

@onready var target = $TargetSphere

func _process(delta):
	global_position = root_attachment.global_position
	target.global_position = get_collision_point()
