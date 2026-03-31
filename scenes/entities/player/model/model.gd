extends Node
class_name PlayerModel

@export var player : CharacterBody3D

@onready var animator : AnimationPlayer = $SkeletonAnimator
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var velocity_calculator : VelocityCalculator = $VelocityCalculator
@onready var skeleton : Skeleton3D = %Skeleton3D
#@onready var rotation_controller : RotationController = $RotationController

var current_state : State

@onready var states = {
	"stand" : $States/Stand,
	"sprint" : $States/Sprint,
	#"sprint" : $States/Sprint,
	#"jump_run" : $States/JumpRun,
	#"midair" : $States/Midair,
	#"landing_run" : $States/LandingRun
}

func _ready() -> void:
	animation_tree.active = true
	current_state = states["stand"]
	#rotation_controller.player = player
	
	for state in states.values():
		state.player = player
		state.velocity_calculator = velocity_calculator
		state.playback = animation_tree["parameters/playback"]

func update(input : InputPackage, delta : float):
	var relevance = current_state.check_relevance(input)
	print(relevance)
	if relevance != current_state.name.to_lower():
		switch_to(relevance)
	current_state.update(input, delta)
	
	#rotation_controller.update(player.velocity.normalized(), delta)
	update_animation_parameters(input)
	pass

func switch_to(next_state : String):
	if not states.has(next_state):
		return
	current_state.on_exit_state()
	current_state = states[next_state]
	current_state.on_enter_state()	
	pass

func update_animation_parameters(input : InputPackage):
	var blend_position = 1 if input.input_direction.y >= 0 else -1;
	print(blend_position)
	animation_tree.set("parameters/Idle/blend_position", blend_position * input.input_direction.length())
	#animation_tree.set("parameters/CombatIdle/blend_position", direction.x)
	pass
