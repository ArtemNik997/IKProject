extends Skeleton3D
class_name PlayerSkeleton

@onready var skeleton_ik : SkeletonIK3D = $SkeletonIK3D

func _ready() -> void:
	PlayerEvents.on_ik_start.connect(start_ik)
	PlayerEvents.on_ik_stop.connect(stop_ik)

func accept_target_node(target_node: Marker3D):
	#print("IK target_node path: ", target_node.get_path())
	#skeleton_ik.target_node = target_node.get_path()
	pass

func start_ik():
	skeleton_ik.start()

func stop_ik():
	skeleton_ik.stop()
