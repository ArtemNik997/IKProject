extends State
class_name Idle

func _ready() -> void:
	animation = "Idle"

func update(input : InputPackage, delta : float):
	player.velocity = Vector3.ZERO

func check_relevance(input: InputPackage) -> String:
	input.actions.sort_custom(state_priority_sort)
	return input.actions[0]
