extends State
class_name Jump

const TRANSITION_TIMING = 1.333
const JUMP_TIMING = 0.1
const JUMP_SPEED := 5.5
const SPEED := 5

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var jumped : bool = false

#func check_relevance(input : InputPackage):
	#if works_longer_than(TRANSITION_TIMING):
		#jumped = false
		#return "midair"
	#else: 
		#return "okay"
#
#func update(input : InputPackage, delta : float):
	#if works_longer_than(JUMP_TIMING):
		#if not jumped:
			#player.velocity.y += JUMP_SPEED
			#jumped = true
	#player.velocity = player.velocity_calculator.velocity_by_input(input, delta, SPEED)
	#player.move_and_slide()

#func on_enter_state():
	#player.velocity.y += JUMP_SPEED
