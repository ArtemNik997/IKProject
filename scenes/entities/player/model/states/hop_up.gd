extends State
class_name HopUp

const SPEED : float = 0.0

var is_climbed : bool = false
var target_rotation_y : float = 0.0
var has_set_direction : bool = false

@export var rotation_blend_speed : float = 12.0

func on_enter_state():
	playback.start(animation_node)
	is_climbed = false

func update(input : InputPackage, delta : float):
	if not has_set_direction:
		var dir2d = input.input_direction
		if dir2d != Vector2.ZERO:
			# Преобразуем 2D направление камеры в угол поворота Y
			target_rotation_y = atan2(dir2d.x, dir2d.y)
		else:
			target_rotation_y = player.rotation.y
		has_set_direction = true
	
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
