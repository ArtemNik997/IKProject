extends State
class_name Emote

const SPEED := 0.0

func on_enter_state():
	PlayerEvents.on_fov_change.emit(fov)	
	PlayerEvents.on_aim_stop.emit()
	playback.travel(animation_node)
	pass

func update(input : InputPackage, delta : float):
	var direction = (player.transform.basis * Vector3(input.input_direction.x, 0, input.input_direction.y)).normalized()
	player.velocity = velocity_calculator.calculate_velocity(
		player.velocity,
		direction,
		player.is_on_floor(),
		delta,
		SPEED
	)
	#player.rotation_controller.mode = "move"
	#player.rotation_controller.update(direction, delta)

	player.move_and_slide()

func check_relevance(input: InputPackage) -> String:
	if PlayerGlobals.player_input_direction != Vector2.ZERO:
		return "stand"
	if not PlayerGlobals.player_is_on_floor:
		return "midair"
	input.actions.sort_custom(state_priority_sort)
	return input.actions[0]
