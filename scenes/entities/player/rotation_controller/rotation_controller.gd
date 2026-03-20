extends Node
class_name RotationController

@export var player : CharacterBody3D

var rotation_speed := 10.0
var mode := "move" # move / aim / lock_on

func update(direction: Vector3, delta: float):
	match mode:
		"move":
			if direction != Vector3.ZERO:
				_rotate_towards(direction, delta)
		
		"aim":
			var forward = -player.camera.global_transform.basis.z
			forward.y = 0
			forward = forward.normalized()
			_rotate_towards(forward, delta)

func _rotate_towards(direction: Vector3, delta: float):
	var target_angle = atan2(direction.x, direction.z)
	player.visuals.rotation.y = lerp_angle(
		player.visuals.rotation.y,
		target_angle,
		rotation_speed * delta
	)
