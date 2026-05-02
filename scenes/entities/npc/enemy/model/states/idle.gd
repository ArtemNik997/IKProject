extends EnemyState
class_name Ground

@export var velocity_calculator: NPCVelocityCalculator
@export var enemy_globals: Node

@onready var wander_timer : Timer = $WanderTimer

const SPEED := 0.5

# Вероятность того, что враг будет двигаться, а не стоять на месте (0.5 = 50%)
@export_range(0.0, 1.0) var wander_probability: float = 0.5

var wander_direction: Vector3 = Vector3.ZERO
var should_wander: bool = false

func _ready() -> void:
	wander_timer.timeout.connect(_on_wander_timeout)
	wander_timer.one_shot = true
	wander_setup()

func on_enter_state():
	playback.travel(animation_node)
	wander_setup()

func update(delta: float):
	if velocity_calculator == null:
		print("velocity_calculator is null:", velocity_calculator == null)
		return

	if wander_timer.is_stopped():
		wander_setup()
	
	if should_wander:
		velocity_calculator.set_movement(wander_direction, SPEED)
		enemy_globals.movement_direction = wander_direction
	else:
		velocity_calculator.set_movement(Vector3.ZERO, 0.0)
		enemy_globals.movement_direction = Vector3.ZERO

func check_relevance(action_package : ActionPackage) -> String:
	action_package.actions.sort_custom(state_priority_sort)
	return action_package.actions[0]

func on_exit_state():
	wander_timer.stop()

func wander_setup():
	wander_timer.wait_time = randf_range(3.0, 7.0)
	should_wander = randf() < wander_probability
	if should_wander:
		wander_direction = get_random_direction()
	else:
		wander_direction = Vector3.ZERO
	wander_timer.start()

func get_random_direction() -> Vector3:
	var angle = randf_range(0, TAU)
	return Vector3(cos(angle), 0, sin(angle)).normalized()

func _on_wander_timeout():
	wander_setup()
