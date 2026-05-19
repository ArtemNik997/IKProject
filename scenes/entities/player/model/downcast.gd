extends RayCast3D
class_name Downcast

@onready var root_attachment = $"../Root"

@onready var target = $TargetSphere
@onready var root = $HipsSphere

@export var landing_distance : float = 0.9

var is_on_floor : bool = false

func _physics_process(delta: float) -> void:
	force_raycast_update()
	global_position = root_attachment.global_position
	if is_colliding():
		target.global_position = get_collision_point()
		target.visible = true
	

	#target.global_position = get_collision_point()
	update_is_on_floor()

func update_is_on_floor():
	if target.global_position.distance_to(root.global_position) < landing_distance:
		is_on_floor = true
		target.material.albedo_color = Color.BLUE
	else:
		is_on_floor = false
		target.material.albedo_color = Color.RED

	#is_on_floor = (root_attachment.global_position.distance_to(target.global_position) < landing_distance)
