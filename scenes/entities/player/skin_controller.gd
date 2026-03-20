extends Node
class_name SkinController

@onready var skin : Node3D = $"../PlayerSkin"

func rotate_skin(target_angle : float, delta : float):
	print("Target angle: ", target_angle)
	if target_angle != 0:
		skin.rotation.y = rotate_toward(skin.rotation.y, target_angle, 6.0 * delta)
