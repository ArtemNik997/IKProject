extends State
class_name MidAir

const SPEED : float = 3.0

@onready var downcast : RayCast3D = $"../../Downcast"

var landing_animation_node : String = "Jump_Land_Fast"

func on_enter_state():
	print("Entered MidAir")
	playback.travel(animation_node)

func update(input : InputPackage, delta : float):
	var direction = (player.transform.basis * Vector3(input.input_direction.x, 0, input.input_direction.y)).normalized()
	player.velocity = velocity_calculator.calculate_velocity(
		player.velocity,
		direction,
		downcast.is_on_floor,
		delta,
		SPEED
	)

	player.move_and_slide()

func on_exit_state():
	print("Exiting MidAir: ", self.name)
	#playback.travel(landing_animation_node)

func check_relevance(input : InputPackage) -> String:
	if downcast.is_on_floor:
		print("landed")
		return "stand"
	return self.name
