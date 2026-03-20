extends State
class_name LandingRun

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

const TRANSITION_TIMING = 0.2

func check_relevance(input : InputPackage):
	#if works_longer_than(TRANSITION_TIMING):
		#input.actions.sort_custom(state_priority_sort)
		#return input.actions[0]
	#else:
		#return "okay"
	pass


func update(input : InputPackage, delta ):
	player.velocity.y -= gravity * delta
	player.move_and_slide()
