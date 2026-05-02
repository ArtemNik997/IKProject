extends Node
class_name StateTemplate
# 1) Redefine class_name

# 2) Redefine animation
func _ready() -> void:
	animation = "animation"

# 3) Define check_relevance 
func check_relevance(input : InputPackage, delta : float):
	pass

# 4) Define update function
func update(input : InputPackage, delta : float):
	pass
