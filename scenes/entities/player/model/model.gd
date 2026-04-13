extends Node
class_name PlayerModel

@export var player : CharacterBody3D

@onready var animator : AnimationPlayer = $SkeletonAnimator
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var velocity_calculator : VelocityCalculator = $VelocityCalculator
@onready var skeleton : PlayerSkeleton = %Skeleton3D
@onready var camera_controller : CameraController = $CameraController
@onready var spine_ik_target : Marker3D = $CameraController/SpineIKTarget

var current_state : State
var curr_blend_pos : float = 0.0

const BLEND_SPEED : float = 3

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
	#skeleton.accept_target_node(spine_ik_target)
	
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
	update_animation_parameters(input, delta)
	pass

func switch_to(next_state : String):
	if not states.has(next_state):
		return
	current_state.on_exit_state()
	current_state = states[next_state]
	current_state.on_enter_state()	
	pass

func update_animation_parameters(input : InputPackage, delta: float):
	var forward_input = 1 if input.player_input.y >= 0 else -1;
	curr_blend_pos = move_toward(curr_blend_pos, forward_input * input.player_input.length(), delta * BLEND_SPEED)
	#print(blend_position)
	animation_tree.set("parameters/Idle/blend_position", curr_blend_pos)
	animation_tree.set("parameters/GunStance/LegsIdle/blend_position", curr_blend_pos)
	if current_state is CombatState:
		animation_tree.set("parameters/GunStance/AnimationTransition/current_state", current_state.animation_transition)
	pass
