extends Node
class_name InputGatherer

var rotation_vector : Vector3 = Vector3.ZERO

#@onready var camera_controller : CameraController = $"../CameraController"

func _ready() -> void:
	PlayerEvents.on_camera_motion.connect(rotate_input_direction)

func gather_input() -> InputPackage:
	var new_input = InputPackage.new()
	new_input.player_input = -Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	new_input.input_direction = new_input.player_input.rotated(-PlayerGlobals.player_camera_rotation.y)
	#.rotated(-camera_controller.rotation.y)

	
	if Input.is_action_pressed("aim"):
		new_input.actions.append("aim")
		if Input.is_action_just_pressed("shoot"):
			new_input.actions.append("shoot")
		if Input.is_action_just_pressed("reload"):
			new_input.actions.append("reload")

	#if Input.is_action_just_pressed("move_jump"):
		#new_input.actions.append("jump_run")
	
	if new_input.input_direction != Vector2.ZERO:
		new_input.actions.append("stand")
		if Input.is_action_pressed("sprint"):
			new_input.actions.append("sprint")

	if new_input.actions.is_empty():
		new_input.actions.append("stand")
	
	return new_input

func rotate_input_direction(rotation_vector: Vector3):
	rotation_vector = rotation_vector
