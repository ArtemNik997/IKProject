extends Node
class_name PlayerModel

@export var player : CharacterBody3D

@onready var animator : AnimationPlayer = $SkeletonAnimator
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var velocity_calculator : VelocityCalculator = $VelocityCalculator
@onready var skeleton : PlayerSkeleton = %Skeleton3D
@onready var camera_controller : CameraController = $CameraController
@onready var marker : Marker3D = $CameraController/Marker3D

var current_state : State

@onready var states = {
	"stand" : $States/Stand,
	"sprint" : $States/Sprint,
	"aim" : $States/Aim,
	"shoot" : $States/Shoot,
	"reload": $States/Reload
}

func _ready() -> void:
	animation_tree.active = true
	current_state = states["stand"]
	camera_controller.character_body = player
	skeleton.accept_target_node(marker)
	
	for state in states.values():
		state.player = player
		state.velocity_calculator = velocity_calculator
		state.playback = animation_tree["parameters/playback"]
		animation_tree.animation_finished.connect(state.on_animation_finished)

func update(input : InputPackage, delta : float):
	var relevance = current_state.check_relevance(input)
	#print(relevance)
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
	#print(blend_position)
	animation_tree.set("parameters/Idle/blend_position", blend_position * input.input_direction.length())
	animation_tree.set("parameters/GunStance/LegsIdle/blend_position", blend_position * input.input_direction.length())
	if current_state is CombatState:
		animation_tree.set("parameters/GunStance/AnimationTransition/current_state", current_state.animation_transition)
	pass
