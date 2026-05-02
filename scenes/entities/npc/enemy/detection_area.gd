extends Area3D
class_name EnemyDetectionArea

@export var enemy_globals: Node

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node3D):
	if body.is_in_group("player"):
		enemy_globals.is_chasing = true
		enemy_globals.player = body
		enemy_globals.can_see_player = true
		enemy_globals.last_known_position = body.global_position
		print("Player entered")

func _on_body_exited(body: Node3D):
	print("Body exited")
	#if body == enemy_globals.player:
		#enemy_globals.is_chasing = false
		#enemy_globals.player = body
		#enemy_globals.can_see_player = false
		#enemy_globals.last_known_position = body.global_position
