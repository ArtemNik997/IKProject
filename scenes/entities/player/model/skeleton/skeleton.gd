extends Skeleton3D
class_name PlayerSkeleton

@export var camera_controller : CameraController
@export var idle_rotation_speed : float = 5.0
@export var aim_rotation_speed : float = 15.0
@onready var spine_ik : CCDIK3D = $SpineCCDIK3D
@onready var spine3_copy_transform_modifier : CopyTransformModifier3D = $Spine3CopyTransformModifier3D
#@onready var head_copy_transform_modifier : CopyTransformModifier3D = $HeadCopyTransformModifier3D
@onready var right_hand_two_bone : TwoBoneIK3D = $RightHandBoneIK3D
@onready var left_hand_two_bone : TwoBoneIK3D = $LeftHandBoneIK3D
@onready var hands_rotation : CopyTransformModifier3D = $HandsCopyTransformModifier3D

var is_rotating : bool = false
var is_aiming : bool = false
var idle_head_offset : Vector3 = Vector3.ZERO

func _ready() -> void:
	aim_ik_stop()
	PlayerEvents.on_aim_start.connect(aim_ik_start)
	PlayerEvents.on_aim_stop.connect(aim_ik_stop)

func _process(delta: float) -> void:
	handle_body_rotation(delta)
	update_hands_ik_targets()

func aim_ik_start():
	is_aiming = true
	spine_ik.active = true
	spine3_copy_transform_modifier.active = true
	right_hand_two_bone.active = true
	left_hand_two_bone.active = true
	hands_rotation.active = true
	

func aim_ik_stop():
	is_aiming = false
	spine_ik.active = false
	spine3_copy_transform_modifier.active = false
	right_hand_two_bone.active = false
	left_hand_two_bone.active = false
	hands_rotation.active = false

func handle_body_rotation(delta: float) -> void:	
	if not camera_controller:
		return

	var skeleton_rot = global_transform.basis.get_euler().y
	var camera_rot = PlayerGlobals.player_camera_rotation.y

	var angle_diff = angle_difference(skeleton_rot, camera_rot)
	
	if abs(angle_diff) > deg_to_rad(70.0):
		is_rotating = true
	
	if is_rotating:
		global_rotation.y = lerp_angle(global_rotation.y, camera_rot, idle_rotation_speed * delta)
		
		if abs(angle_difference(global_rotation.y, camera_rot)) < deg_to_rad(2.0):
			is_rotating = false

func update_hands_ik_targets():
	if PlayerGlobals.player_current_weapon:
		var rh_path = PlayerGlobals.player_current_weapon.rh_target.get_path()
		var lh_path = PlayerGlobals.player_current_weapon.lh_target.get_path()
		
		hands_rotation.set("settings/0/reference_node", rh_path)
		hands_rotation.set("settings/1/reference_node", lh_path)
		right_hand_two_bone.set("settings/0/target_node", rh_path)
		left_hand_two_bone.set("settings/0/target_node", lh_path)
	else:
		push_error("PlayerGlobals.player_current_weapon is null")
	pass

func accept_target_node(target_node: Marker3D):
	var path = spine_ik.get_path_to(target_node)
	spine_ik.set_target_node(0, path)
