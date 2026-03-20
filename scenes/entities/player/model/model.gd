extends Node
class_name PlayerModel

@export var player : CharacterBody3D

@onready var animator : AnimationPlayer = $SkeletonAnimator
@onready var velocity_calculator : VelocityCalculator = $VelocityCalculator
@onready var skeleton : Skeleton3D = %Skeleton3D

var current_state : State

@onready var states = {
	"idle" : $States/Idle,
	"run" : $States/Run,
	#"sprint" : $States/Sprint,
	#"jump_run" : $States/JumpRun,
	#"midair" : $States/Midair,
	#"landing_run" : $States/LandingRun
}

func _ready() -> void:
	current_state = states["idle"]
	for state in states.values():
		state.player = player
		state.velocity_calculator = velocity_calculator

func update(input : InputPackage, delta : float):
	var relevance = current_state.check_relevance(input)
	print("Current action: ", input.actions[0])
	if relevance != "okay" and relevance != current_state.name:
		switch_to(relevance)
	current_state.update(input, delta)
	print("Current state: ", current_state.name)
	pass

func switch_to(next_state : String):
	current_state.on_exit_state()
	current_state = states[next_state]
	current_state.on_enter_state()
	animator.play(current_state.animation)
	pass
