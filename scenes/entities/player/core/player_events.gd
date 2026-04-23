extends Node

# Camera signals
signal on_camera_motion(rotation_vector : Vector3)
signal on_fov_change(fov : float)
signal on_camera_change(fov: float, arm_length : float)

# Animation signals
signal on_animation_tree_parameter_change(param_path : String, value: Variant)

# SpineIK signals
signal on_ik_start()
signal on_ik_stop()


signal on_aim_start()
signal on_aim_stop()

signal on_player_shot()
