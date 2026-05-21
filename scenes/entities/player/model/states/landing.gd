extends State
class_name Landing

const SPEED : float = 0.0

var is_landed = false

func on_enter_state():
	is_landed = false
	playback.travel(animation_node)

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

func check_relevance(input : InputPackage) -> String:
	if is_landed:
		input.actions.sort_custom(state_priority_sort)
		return input.actions[0]
	return self.name

func on_exit_state():
	is_landed = false

func on_animation_finished(animation_name: String):
	if animation_name == animation_node:
		is_landed = true
