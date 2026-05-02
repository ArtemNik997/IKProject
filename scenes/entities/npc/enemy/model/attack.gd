extends EnemyState
class_name Attack

var is_attacked : bool = false

func on_enter_state():
	is_attacked = false
	playback.travel(animation_node)

func check_relevance(action_package : ActionPackage) -> String:
	if is_attacked:
		action_package.actions.sort_custom(state_priority_sort)
		return action_package.actions[0]
	return self.name


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack":
		is_attacked = true
