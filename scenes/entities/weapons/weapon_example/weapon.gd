extends Node3D
class_name Weapon

@export var aim_target : Marker3D

func _physics_process(delta: float) -> void:
	#look_at(aim_target.global_position, Vector3.UP, true)
	pass
