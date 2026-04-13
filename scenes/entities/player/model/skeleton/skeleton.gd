extends Skeleton3D
class_name PlayerSkeleton

#@onready var skeleton_ik : SkeletonIK3D = $SkeletonIK3D
@onready var spine_ik : CCDIK3D = $SpineCCDIK3D

func _ready() -> void:
	spine_ik.active = false
	PlayerEvents.on_ik_start.connect(start_ik)
	PlayerEvents.on_ik_stop.connect(stop_ik)

func accept_target_node(target_node: Marker3D):
	var path = spine_ik.get_path_to(target_node)
	spine_ik.set_target_node(0, path)

func _process(delta: float) -> void:
	#print("IK active: ", spine_ik.active)
	pass
	

func start_ik():
	spine_ik.active = true
	pass

func stop_ik():
	spine_ik.active = false
	pass
