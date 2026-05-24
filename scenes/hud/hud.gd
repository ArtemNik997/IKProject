extends Control
class_name HUD

@onready var player_vars : TextEdit = $PlayerVars

var vars : String = ""

func _process(delta: float) -> void:
	var near_wall = "Near wall: " + str(PlayerGlobals.player_near_wall)
	var can_climb = "* Can climb: " + str(PlayerGlobals.player_can_climb)
	var can_hopup = "* Can hopup: " + str(PlayerGlobals.player_can_hopup)
	player_vars.text = near_wall + "\n" + can_climb + "\n" + can_hopup
