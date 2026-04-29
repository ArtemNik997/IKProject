extends CharacterBody3D
class_name Enemy

var player : Player = null

#@export var player_node_path : NodePath
const SPEED = 3.0
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var nav_agent : NavigationAgent3D = $NavigationAgent3D

func _ready() -> void:
	#player_node_path = get_node(player_node_path)
	player = GameGlobals.player
	pass

func _process(delta: float) -> void:
	# Path finding
	velocity = Vector3.ZERO
	nav_agent.target_position = GameGlobals.player.global_transform.origin
	var next_path_pos = nav_agent.get_next_path_position()
	velocity = (next_path_pos - global_transform.origin).normalized() * SPEED
	
	look_at(Vector3(GameGlobals.player.global_position.x, global_position.y , GameGlobals.player.global_position.z), Vector3.UP)

func _physics_process(delta: float) -> void:
	look_at(player.global_position, Vector3.UP)
	if not is_on_floor():
		velocity.y -= gravity * delta
	move_and_slide()
