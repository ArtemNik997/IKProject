extends CharacterBody3D
class_name Player

@onready var camera : Node3D = $CameraController/SpringArm3D/Camera3D
@onready var input_gatherer : InputGatherer = $Input
@onready var model : PlayerModel = $Model
@onready var visuals : Node3D = $Visuals
@onready var rotation_controller: RotationController = $RotationController

@export var jump_speed := 4.0
@export var base_speed := 4.0

func _ready() -> void:
	visuals.accept_skeleton(model.skeleton)

func _physics_process(delta: float) -> void:
	var input = input_gatherer.gather_input()
	model.update(input, delta)
	input.queue_free()
