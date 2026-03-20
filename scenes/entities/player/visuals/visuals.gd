extends Node3D

@onready var mannequin : MeshInstance3D = $Mannequin

func accept_skeleton(skeleton : Skeleton3D):
	mannequin.skeleton = skeleton.get_path()
	pass
