extends Node
class_name EnemyState

@export var enemy : CharacterBody3D
@export var animation_node : String
#@export var velocity_calculator: NPCVelocityCalculator

var playback : AnimationNodeStateMachinePlayback

static var state_priority : Dictionary = {
	"wander" : 1,
	"chase" : 2,
	"attack": 3,
	"death": 10,
	"spawn": 11
}

var enter_state_time : float

static func state_priority_sort(a : String, b : String):
	if state_priority[a] > state_priority[b]:
		return true
	else:
		return false

#func check_relevance(input : InputPackage) -> String:
	#print_debug("error, implement the check_relevance function on your state")
	#return "error, implement the check_relevance function on your state"

func update(delta : float):
	pass

func on_enter_state():
	pass

func on_exit_state():
	pass

func on_animation_finished(animation_name: String):
	pass
