extends CombatState
class_name Aim

const SPEED := 4

func on_enter_state():
	PlayerEvents.on_fov_change.emit(fov)
	playback.travel(animation_node)

func check_relevance(input : InputPackage) -> String:
	if not player.is_on_floor():
		return "midair"

	input.actions.sort_custom(state_priority_sort)
	return input.actions[0]

func update(input : InputPackage, delta : float):
	var direction = (player.transform.basis * Vector3(input.input_direction.x, 0, input.input_direction.y)).normalized()
	player.velocity = velocity_calculator.calculate_velocity(
		player.velocity,
		direction,
		player.is_on_floor(),
		delta,
		SPEED
	)

	player.move_and_slide()

func on_exit_state():
	#PlayerEvents.on_exit_aim.emit()
	pass
