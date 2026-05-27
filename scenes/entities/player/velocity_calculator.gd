extends Node
class_name VelocityCalculator

@export var animation_tree : AnimationTree

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var calculated_velocity = Vector3.ZERO

func calculate_velocity(
	current_velocity: Vector3,
	direction: Vector3,
	is_on_floor: bool,
	delta: float,
	speed: float
) -> Vector3:
	var new_velocity = current_velocity
	
	#print("Direction == Vector3Zero:", direction == Vector3.ZERO )
	#new_velocity = direction * speed
	##if direction != Vector3.ZERO:
		##new_velocity = direction * speed

	if direction != Vector3.ZERO:
		PlayerGlobals.player_is_rotating = true
		new_velocity.x = direction.x * speed
		new_velocity.z = direction.z * speed
	else:
		PlayerGlobals.player_is_rotating = false
		new_velocity.x = 0
		new_velocity.z = 0

	if not is_on_floor:
		new_velocity.y -= gravity * delta
	
	calculated_velocity = new_velocity
	
	return new_velocity

func get_root_motion_velocity(delta: float) -> Vector3:
	if animation_tree == null or not animation_tree.active or delta <= 0.0:
		return Vector3.ZERO
	
	var root_pos_delta = animation_tree.get_root_motion_position()
	var local_vel = root_pos_delta / delta
	
	# Поворачиваем вектор скорости вокруг мировой оси Y на угол камеры
	var cam_yaw = PlayerGlobals.player_camera_rotation.y
	var world_vel = local_vel.rotated(Vector3.UP, cam_yaw)
	
	return world_vel
