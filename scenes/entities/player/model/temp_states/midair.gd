extends State
class_name Midair
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

const SPEED := 5.0

@onready var downcast = $"../../Downcast"
@onready var root_attachment = $"../../Root"

var landing_height : float = 0.9

func check_relevance(_input : InputPackage):
	var floor_point = downcast.get_collision_point()
	if root_attachment.global_position.distance_to(floor_point) < landing_height:
		print("Character is landing")
		var xz_velocity = player.velocity
		xz_velocity.y = 0
		return "landing_run"
	else:
		return "okay"

func update(input : InputPackage, delta ):
	player.velocity = player.velocity_calculator.velocity_by_input(input, delta, SPEED)
	player.move_and_slide()
