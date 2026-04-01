extends Node

# Camera signals
signal on_fov_change(fov : float)

# Animation signals
signal on_animation_tree_parameter_change(param_path : String, value: Variant)

# SkeletonIK3D signals
signal on_ik_start()
signal on_ik_stop()
