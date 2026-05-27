extends CharacterBody3D
class_name Player

@onready var input_gatherer : InputGatherer = $InputGatherer
@onready var model : PlayerModel = $PlayerModel

var input : InputPackage = InputPackage.new()

func _ready() -> void:
	GameGlobals.player = self
	pass

func _physics_process(delta: float) -> void:
	input = input_gatherer.gather_input()
	model.update(input, delta)
	input.queue_free()


#@onready var visuals : Node3D = $Visuals
#@onready var rotation_controller: RotationController = $RotationController
