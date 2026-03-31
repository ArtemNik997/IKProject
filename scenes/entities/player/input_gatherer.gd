extends Node
class_name InputGatherer

@onready var camera : Camera3D = $"../CameraController/SpringArm3D/Camera3D"

func gather_input() -> InputPackage:
	var new_input = InputPackage.new()
	new_input.input_direction = -Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	#new_input.input_direction = new_input.input_direction_no_rotation

	#print(new_input.input_direction_no_rotation.y)
	
	if Input.is_action_pressed("aim"):
		new_input.actions.append("aim")
		#if Input.is_action_just_pressed("shoot"):
			#new_input.actions.append("shoot")

	#if Input.is_action_just_pressed("move_jump"):
		#new_input.actions.append("jump_run")
	
	if new_input.input_direction != Vector2.ZERO:
		new_input.actions.append("stand")
		if Input.is_action_pressed("sprint"):
			new_input.actions.append("sprint")

	if new_input.actions.is_empty():
		new_input.actions.append("stand")
	
	return new_input
