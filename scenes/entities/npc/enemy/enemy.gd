extends CharacterBody3D
class_name Enemy

var player : Player = null

#const SPEED = 3.0
#var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var enemy_model : EnemyModel = $EnemyModel
@onready var action_gatherer : ActionGatherer = $ActionGatherer

func _ready() -> void:
	player = GameGlobals.player
	pass

func _physics_process(delta: float) -> void:
	var action_package = action_gatherer.gather_action()
	enemy_model.update(delta, action_package)
	move_and_slide()

#func find_path_direction() -> Vector3:
	#velocity = Vector3.ZERO
	#nav_agent.target_position = GameGlobals.player.global_transform.origin
	#var next_path_pos = nav_agent.get_next_path_position()
	#return (next_path_pos - global_transform.origin).normalized()
