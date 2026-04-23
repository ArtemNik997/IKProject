extends Node3D
class_name CameraController

@onready var head : Node3D = $"."
@onready var camera : Camera3D = $"SpringArm3D/PlayerCamera"
#@onready var camera_aim_target : Marker3D = $SpringArm3D/PlayerCamera/SpringArm3D/CameraAimTarget
@onready var camera_aim_cast : RayCast3D = $SpringArm3D/PlayerCamera/RayCast3D

@export_group("Camera")
@export_range(0.0, 1.0) var camera_sensivity = 0.5
@export var character_body : CharacterBody3D
@export var target_fov : float = 75
@export var target_arm_length : float = 2
@export var fov_change_speed : float = 150
@export var arm_length_change_speed : float = 150

@export_group("IK Targets")
@export var aim_target : Marker3D

var camera_input_direction = Vector2.ZERO
var rotation_vector = Vector3.ZERO
var std_fov = 0

func _ready() -> void:
	std_fov = target_fov
	PlayerEvents.on_fov_change.connect(change_fov)
	PlayerEvents.on_camera_change.connect(change_camera)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _process(delta: float) -> void:
	head.rotation_degrees.x = rotation_vector.x
	head.rotation_degrees.y = rotation_vector.y
	camera.fov = move_toward(camera.fov, target_fov, delta * fov_change_speed)
	PlayerGlobals.player_camera_rotation = rotation
	#aim_target.position = camera_aim_target.position
	aim_target.position = camera_aim_cast.target_position

func _unhandled_input(event: InputEvent) -> void:
	var is_camera_motion := (
		event is InputEventMouseMotion
		and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	)
	
	if is_camera_motion:
		rotation_vector.y -= (event.screen_relative.x * camera_sensivity) # yaw
		rotation_vector.x += (event.screen_relative.y * camera_sensivity) # pitch
		rotation_vector.x = clamp(rotation_vector.x, -90.0, 90.0)
		rotation_vector.y = wrapf(rotation_vector.y, 0.0,  360.0)
		#PlayerEvents.on_camera_motion.emit(rotation_vector)

func change_fov(fov : float):
	print("New camera fov: ", fov)
	target_fov = fov
	pass

func reset_fov():
	print("Resetting camera fov")
	target_fov = std_fov
	pass

func change_camera(fov : float, arm_length: float):
	print("New camera fov: ", fov)
	target_fov = fov
	target_arm_length = arm_length
	pass
