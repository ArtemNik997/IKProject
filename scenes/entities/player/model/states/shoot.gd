extends CombatState
class_name Shoot

const SPEED := 4

var is_weapon_shot : bool = false

func on_enter_state():
	PlayerEvents.on_fov_change.emit(fov)
	playback.travel(animation_node)
	PlayerEvents.on_animation_tree_parameter_change.emit("parameters/GunStance/ShootAnimTrigger/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

	#PlayerEvents.on_ik_start.emit()
	PlayerEvents.on_aim_start.emit()
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

	player.move_and_slide()

func check_relevance(input : InputPackage) -> String:
	if is_weapon_shot:
		input.actions.sort_custom(state_priority_sort)
		return input.actions[0]
	return self.name

func on_animation_finished(animation_name: String):
	if animation_name == "Pistol_Shoot":
		is_weapon_shot = true

func on_exit_state():
	is_weapon_shot = false
