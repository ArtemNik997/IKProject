extends Node
class_name VelocityCalculator

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

	if direction != Vector3.ZERO:
		new_velocity.x = direction.x * speed
		new_velocity.z = direction.z * speed
	else:
		new_velocity.x = 0
		new_velocity.z = 0

	if not is_on_floor:
		new_velocity.y -= gravity * delta
	
	calculated_velocity = new_velocity
	
	return new_velocity
