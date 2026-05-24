extends State
class_name HopUp

const SPEED : float = 0.0

var is_climbed : bool = false

func on_enter_state():
	playback.travel(animation_node)
	is_climbed = false

func update(input : InputPackage, delta : float):
	# Получаем вектор скорости из анимации
	#var root_vel = velocity_calculator.get_root_motion_velocity(delta)
	#
	## Применяем root motion к velocity
	#player.velocity.x = root_vel.x
	#player.velocity.z = root_vel.z
	## Y-компонент берём из анимации (персонаж сам "подтягивается" над уступом)
	#player.velocity.y = root_vel.y
	player.velocity = velocity_calculator.get_root_motion_velocity(delta)
	
	player.move_and_slide()

func check_relevance(input : InputPackage) -> String:
	if is_climbed:
		print("HopUp finished")
		#input.actions.sort_custom(state_priority_sort)
		return "stand"
	return self.name

func on_exit_state():
	print("HopUp finished")
	is_climbed = false

func on_animation_finished(animation_name: String):
	if playback.get_current_node() == animation_node:
		is_climbed = true
	#is_climbed = (animation_name == animation_node)
