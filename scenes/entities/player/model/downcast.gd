extends RayCast3D
class_name Downcast

@onready var root_attachment = $"../Root"

@onready var target = $TargetSphere

@export var landing_distance : float = 0.9

var is_on_floor : bool = false

func _process(delta):
	global_position = root_attachment.global_position
	target.global_position = get_collision_point()
	update_is_on_floor()

func update_is_on_floor():
	is_on_floor = (root_attachment.global_position.distance_to(target.global_position) < landing_distance)
