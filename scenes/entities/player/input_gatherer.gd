extends Node
class_name InputGatherer

var rotation_vector : Vector3 = Vector3.ZERO

func gather_input() -> InputPackage:
	var new_input = InputPackage.new()
	new_input.player_input = -Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	PlayerGlobals.player_input_direction = new_input.player_input
	new_input.input_direction = new_input.player_input.rotated(-PlayerGlobals.player_camera_rotation.y)
	
	if Input.is_action_pressed("crouch"):
		new_input.actions.append("crouch")
	
	if Input.is_action_pressed("aim"):
		new_input.actions.append("aim")
		if Input.is_action_just_pressed("shoot"):
			new_input.actions.append("shoot")
		if Input.is_action_just_pressed("reload"):
			new_input.actions.append("reload")
	
	if new_input.input_direction != Vector2.ZERO:
		new_input.actions.append("stand")
		if PlayerGlobals.player_can_hopup and new_input.player_input.y > 0:
			new_input.actions.append("hopup")
		if Input.is_action_pressed("sprint"):
			new_input.actions.append("sprint")
			if Input.is_action_just_pressed("jump"):
				new_input.actions.append("jumpsprint")
	
	if Input.is_action_just_pressed("jump"):
		new_input.actions.append("jumpstand")
	
	if Input.is_action_just_pressed("get_primary_weapon"):
		PlayerEvents.on_weapon_switch.emit("primary")
	
	if Input.is_action_just_pressed("get_secondary_weapon"):
		PlayerEvents.on_weapon_switch.emit("secondary")
	
	if Input.is_action_just_pressed("get_tertiary_weapon"):
		PlayerEvents.on_weapon_switch.emit("tertiary")
	
	if Input.is_action_just_pressed("get_dual_blasters"):
		PlayerEvents.on_weapon_switch.emit("dual")
	
	if Input.is_action_just_pressed("emote"):
		new_input.actions.append("emote")
	
	if new_input.actions.is_empty():
		new_input.actions.append("stand")
	
	return new_input

func rotate_input_direction(rotation_vector: Vector3):
	rotation_vector = rotation_vector

#@onready var camera_controller : CameraController = $"../CameraController"

func _ready() -> void:
	#PlayerEvents.on_camera_motion.connect(rotate_input_direction)
	pass
