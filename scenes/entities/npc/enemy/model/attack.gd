extends EnemyState
class_name Attack

@export var velocity_calculator : NPCVelocityCalculator
@export var enemy_globals : EnemyGlobals 

var is_attacked : bool = false

const SPEED := 0.0

func on_enter_state():
	is_attacked = false
	playback.travel(animation_node)

func check_relevance(action_package : ActionPackage) -> String:
	if is_attacked:
		action_package.actions.sort_custom(state_priority_sort)
		if action_package.actions[0] == self.name.to_lower():
			print("Continue attack")
			play_attack_animation()
			return self.name
		return action_package.actions[0]
	return self.name

func update(delta : float):
	enemy_globals.movement_direction = Vector3.ZERO
	velocity_calculator.set_movement(enemy_globals.movement_direction, SPEED)

func on_exit_state():
	is_attacked = false

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack":
		is_attacked = true

func play_attack_animation():
	is_attacked = false
	playback.start(animation_node, true)
