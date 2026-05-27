extends State
class_name JumpStand

const SPEED : float = 5.0
const VERTICAL_SPEED : float = 5.0

var is_jumped = false

#@onready var downcast : RayCast3D = $"../../Downcast"

func on_enter_state():
	playback.travel(animation_node)
	player.velocity.y += VERTICAL_SPEED
	is_jumped = false

func update(input : InputPackage, delta : float):
	var direction = (player.transform.basis * Vector3(input.input_direction.x, 0, input.input_direction.y)).normalized()
	player.velocity = velocity_calculator.calculate_velocity(
		player.velocity,
		direction,
		PlayerGlobals.player_is_on_floor,
		delta,
		SPEED
	)

	player.move_and_slide()

func check_relevance(input: InputPackage) -> String:
	input.actions.sort_custom(state_priority_sort)
	if is_jumped:
		return "midair"
	return self.name

func on_exit_state():
	is_jumped = false

func on_animation_finished(animation_name: String):
	if animation_name == animation_node:
		#print(animation_name)
		is_jumped = true
