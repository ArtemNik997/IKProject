extends Node3D

@export_group("Camera")
@export_range(0.0, 1.0) var camera_sensivity = 0.5

@export var character_body : CharacterBody3D
@onready var head : Node3D = $"."

var camera_input_direction = Vector2.ZERO
var rotation_vector = Vector3.ZERO

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _process(delta: float) -> void:
	head.rotation_degrees.x = rotation_vector.x
	character_body.rotation_degrees.y = rotation_vector.y

func _unhandled_input(event: InputEvent) -> void:
	var is_camera_motion := (
		event is InputEventMouseMotion
		and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	)
	
	if is_camera_motion:
		#camera_input_direction = event.screen_relative * camera_sensivity
		rotation_vector.y -= (event.screen_relative.x * camera_sensivity) # yaw
		rotation_vector.x += (event.screen_relative.y * camera_sensivity) # pitch
		rotation_vector.x = clamp(rotation_vector.x, -90.0, 45.0)
		#rotation_vector.y = wrapf(rotation_vector.y, 0.0, TAU)
	

func _physics_process(delta: float) -> void:
	#rotation.x += camera_input_direction.y * delta
	#rotation.x = clamp(rotation.x, -PI/2.0, PI/4.0)
	#rotation.y -= camera_input_direction.x * delta
	#rotation.y = wrapf(rotation.y, 0.0, TAU)
	#
	#camera_input_direction = Vector2.ZERO
	pass
	
