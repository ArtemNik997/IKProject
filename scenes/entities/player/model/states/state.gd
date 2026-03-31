extends Node
class_name State

@export var player : CharacterBody3D
@export var animation : String
@export var velocity_calculator: VelocityCalculator

var playback : AnimationNodeStateMachinePlayback

static var state_priority : Dictionary = {
	"stand" : 1,
	"aim" : 2,
	"sprint" : 4,
	"midair" : 10
}

var enter_state_time : float

static func state_priority_sort(a : String, b : String):
	if state_priority[a] > state_priority[b]:
		return true
	else:
		return false

func check_relevance(input : InputPackage) -> String:
	print_debug("error, implement the check_relevance function on your state")
	return "error, implement the check_relevance function on your state"

func update(input : InputPackage, delta : float):
	pass

func on_enter_state():
	pass

func on_exit_state():
	pass
