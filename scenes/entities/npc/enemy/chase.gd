extends EnemyState
class_name Chase

@export var velocity_calculator: NPCVelocityCalculator
@export var enemy_globals: Node

const SPEED = 1.5

func on_enter_state():
	playback.travel(animation_node)

func update(delta : float):
	if velocity_calculator == null or enemy_globals == null:
		print("velocity_calculator is null:", velocity_calculator == null)
		print("enemy_globals is null:", enemy_globals == null)
		return
	
	var to_player = (enemy_globals.player.global_position - enemy.global_position).normalized()
	to_player.y = 0
	enemy_globals.movement_direction = to_player
	velocity_calculator.set_movement(to_player, SPEED)

func check_relevance(action_package : ActionPackage) -> String:
	action_package.actions.sort_custom(state_priority_sort)
	return action_package.actions[0]
