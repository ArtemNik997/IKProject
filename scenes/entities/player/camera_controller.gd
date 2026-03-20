extends Node3D

@export_group("Camera")
@export_range(0.0, 1.0) var camera_sensivity = 0.5

var camera_input_direction = Vector2.ZERO

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _unhandled_input(event: InputEvent) -> void:
	var is_camera_motion := (
		event is InputEventMouseMotion
		and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	)
	
	if is_camera_motion:
		camera_input_direction = event.screen_relative * camera_sensivity
	

func _physics_process(delta: float) -> void:
	rotation.x += camera_input_direction.y * delta
	rotation.x = clamp(rotation.x, -PI/2.0, PI/4.0)
	rotation.y -= camera_input_direction.x * delta
	rotation.y = wrapf(rotation.y, 0.0, TAU)
	
	camera_input_direction = Vector2.ZERO
	
