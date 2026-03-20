extends State
class_name Sprint

const SPEED := 8

func check_relevance(input : InputPackage):
	#if not player.is_on_floor():
		#return "midair"
	input.actions.sort_custom(state_priority_sort)
	if input.actions[0] == "sprint":
		return "okay"
	return input.actions[0]

func update(input : InputPackage, delta : float):
	player.velocity = player.velocity_calculator.velocity_by_input(input, delta, SPEED)
	player.move_and_slide()
