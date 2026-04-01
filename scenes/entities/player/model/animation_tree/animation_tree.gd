extends AnimationTree


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerEvents.on_animation_tree_parameter_change.connect(change_animation_tree_parameter)

func change_animation_tree_parameter(param_path: String, value: Variant):
	self.set(param_path, value)
	pass
