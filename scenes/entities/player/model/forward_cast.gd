extends Node3D
class_name ForwardCast

@onready var head_cast : RayCast3D = $HeadCast
@onready var hips_cast : RayCast3D = $HipsCast
@onready var feet_cast : RayCast3D = $FeetCast

func _physics_process(delta: float) -> void:
	if feet_cast.is_colliding():
		PlayerGlobals.player_near_wall = true
		if not head_cast.is_colliding():
			PlayerGlobals.player_can_climb = true
		else:
			PlayerGlobals.player_can_climb = false
	PlayerGlobals.player_near_wall = false
	PlayerGlobals.player_can_climb = false
