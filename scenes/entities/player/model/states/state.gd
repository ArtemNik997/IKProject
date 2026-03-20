extends Node
class_name State

@export var player : CharacterBody3D
@export var animation : String
@export var velocity_calculator: VelocityCalculator

static var state_priority : Dictionary = {
	"idle" : 1,
	"run" : 2,
	"sprint" : 3,
	"jump_run" : 10,
	"midair" : 10,
	"landing_run" : 10,
	"jump_sprint" : 10,
	"landing_sprint" : 10,
	"slash_1" : 15,
	"slash_2" : 15,
	"slash_3" :15
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
