extends Node
class_name EnemyModel

@export var enemy : CharacterBody3D

@onready var animator : AnimationPlayer = $visuals/AnimationPlayer
@onready var animation_tree : AnimationTree = $visuals/AnimationTree
@onready var skeleton : Skeleton3D = $visuals/undead/Skeleton3D
@onready var velocity_calculator: NPCVelocityCalculator = $NPCVelocityCalculator
@onready var enemy_globals: Node = $EnemyGlobals
@onready var nav_agent : NavigationAgent3D = $NavigationAgent3D
@onready var action_gatherer : ActionGatherer = $ActionGatherer

var current_state : EnemyState
var curr_blend_pos : float = 0.0
var look_direction
var player : Player = null
var rotation_speed: float = 1.0
var blend_position : float = 0.0

const BLEND_SPEED : float = 3

@onready var states = {
	"wander" : $States/Wander,
	"chase" : $States/Chase,
	"attack" : $States/Attack
}

func _ready() -> void:
	animation_tree.active = true
	current_state = states["wander"]
	velocity_calculator.npc = enemy
	
	for state in states.values():
		state.enemy = enemy
		state.playback = animation_tree["parameters/playback"]
		pass

func update(delta : float, action_package2 : ActionPackage):
	var action_package = action_gatherer.gather_action()
	var relevance = current_state.check_relevance(action_package)
	#print(relevance)
	if relevance != current_state.name.to_lower():
		switch_to(relevance)
	current_state.update(delta)
	
	update_animation_parameters(delta)
	rotate_character(delta)
	pass

func switch_to(next_state : String):
	if not states.has(next_state):
		return
	current_state.on_exit_state()
	current_state = states[next_state]
	current_state.on_enter_state()
	pass

func update_animation_parameters(delta: float):
	blend_position = move_toward(blend_position, 
		enemy.velocity.normalized().length(), delta * BLEND_SPEED)
	animation_tree.set("parameters/Ground/blend_position", blend_position)
	pass

func find_path_direction() -> Vector3:
	enemy.velocity = Vector3.ZERO
	nav_agent.target_position = GameGlobals.player.global_transform.origin
	var next_path_pos = nav_agent.get_next_path_position()
	return (next_path_pos - enemy.global_transform.origin).normalized()

func rotate_character(delta: float):
	if enemy_globals.movement_direction != Vector3.ZERO:
		var target_angle = atan2(enemy_globals.movement_direction.x,
		enemy_globals.movement_direction.z)
		enemy.rotation.y = lerp_angle(enemy.rotation.y, target_angle, rotation_speed * delta)
