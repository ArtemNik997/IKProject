extends Node
class_name NPCVelocityCalculator

@export var npc: CharacterBody3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var _current_direction: Vector3 = Vector3.ZERO
var _current_speed: float = 0.0
var _target_velocity: Vector3 = Vector3.ZERO

func _physics_process(delta: float) -> void:
	if npc == null:
		return
	
	if not npc.is_on_floor():
		_target_velocity.y -= gravity * delta
	
	_target_velocity.x = _current_direction.x * _current_speed
	_target_velocity.z = _current_direction.z * _current_speed
	
	npc.velocity = _target_velocity * _current_speed
	npc.move_and_slide()

func set_movement(direction: Vector3, speed: float) -> void:
	_current_direction = direction.normalized()
	_current_speed = speed
	#print("Current speed: ", _current_speed)

func stop() -> void:
	_current_direction = Vector3.ZERO
	_current_speed = 0.0
	_target_velocity = Vector3.ZERO
