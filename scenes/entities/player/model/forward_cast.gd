extends Node3D
class_name ForwardCast

@onready var head_cast : RayCast3D = $HeadCast
@onready var hips_cast : RayCast3D = $HipsCast
@onready var feet_cast : RayCast3D = $FeetCast

func _physics_process(_delta: float) -> void:
	PlayerGlobals.player_near_wall = feet_cast.is_colliding() or hips_cast.is_colliding() or head_cast.is_colliding()
	if PlayerGlobals.player_near_wall:
		PlayerGlobals.player_can_climb = hips_cast.is_colliding() and not head_cast.is_colliding()
		PlayerGlobals.player_can_hopup = not hips_cast.is_colliding()
	else:
		PlayerGlobals.player_can_climb = false
		PlayerGlobals.player_can_hopup = false
