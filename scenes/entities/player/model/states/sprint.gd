extends State
class_name Sprint

const SPEED := 10

func on_enter_state():
	playback.travel(animation)
	pass

func check_relevance(input : InputPackage) -> String:
	if not player.is_on_floor():
		return "midair"

	input.actions.sort_custom(state_priority_sort)
	if input.actions[0] == "sprint":
		return "sprint"
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
