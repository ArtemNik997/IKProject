extends Area3D
class_name Target

var is_destroyed: bool = false

func _ready() -> void:
	pass

func take_damage() -> void:
	print("Taking damage")
	if is_destroyed:
		return
	
	is_destroyed = true
	
	queue_free()
