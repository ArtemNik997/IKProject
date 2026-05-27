extends Node3D
class_name PlayerVisuals

@export var model : PlayerModel

@onready var mannequin : MeshInstance3D = $Mannequin

func accept_model(_model : PlayerModel):
	model = _model
	mannequin.skeleton = model.skeleton.get_path()
