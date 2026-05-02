extends Node3D
class_name TargetManager

@export var enemy_globals : EnemyGlobals

@onready var head_target : Marker3D = $HeadTarget

@export var head_tracking_speed: float = 5.0

func _process(delta: float) -> void:
	if enemy_globals.player != null:
		var target_pos := enemy_globals.player.global_position
		var desired_transform := head_target.global_transform.looking_at(target_pos, Vector3.UP, true)
		head_target.global_transform = head_target.global_transform.interpolate_with(
		desired_transform,
		clamp(head_tracking_speed * delta, 0.0, 1.0)
	)

#func _process(delta: float) -> void:
	#if enemy_globals.player != null:
		#print("Rotating target")
		#var target_position = enemy_globals.player.global_position
		#head_target.global_position = head_target.global_position.lerp(
			#target_position, 
			#head_tracking_speed * delta
		#)
	#pass
