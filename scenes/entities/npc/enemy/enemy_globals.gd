extends Node
class_name EnemyGlobals

var movement_direction : Vector3 = Vector3.ZERO

var player: Player = null

var is_chasing: bool = false
var last_known_position: Vector3 = Vector3.ZERO
var can_see_player: bool = false

func _ready():
	player = GameGlobals.player
