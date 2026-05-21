extends Node
class_name EnemyGlobals

var movement_direction : Vector3 = Vector3.ZERO

var player: Player:
	get: return GameGlobals.player

var is_chasing: bool = false
var last_known_position: Vector3 = Vector3.ZERO
var can_see_player: bool = false

func _ready():
	#print("Player is null: ", GameGlobals.player == null)
	#if GameGlobals.player == null:
		#print("Player is null")
	#else:
		#player = GameGlobals.player
	pass
