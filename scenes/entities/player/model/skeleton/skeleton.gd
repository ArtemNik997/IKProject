extends Skeleton3D
class_name PlayerSkeleton

@export var camera_controller : CameraController
@export var rotation_speed : float = 5.0 # Скорость доводки персонажа
@onready var spine_ik : CCDIK3D = $SpineCCDIK3D

var is_rotating : bool = false

func _ready() -> void:
	spine_ik.active = false
	PlayerEvents.on_ik_start.connect(start_ik)
	PlayerEvents.on_ik_stop.connect(stop_ik)

func _process(delta: float) -> void:
	handle_body_rotation(delta)
	#print("Skeleton")

func handle_body_rotation(delta: float) -> void:
	if not camera_controller:
		return
		
	# 1. Текущий угол скелета и угол камеры
	var skeleton_rot = global_transform.basis.get_euler().y
	var camera_rot = PlayerGlobals.player_camera_rotation.y
	
	# 2. Вычисляем разницу
	var angle_diff = angle_difference(skeleton_rot, camera_rot)
	
	# 3. Логика порога 60 градусов
	# Если мы вышли за пределы 60 градусов (1.047 радиана)
	if abs(angle_diff) > deg_to_rad(60.0):
		is_rotating = true
	
	# 4. Если мы в режиме вращения, плавно поворачиваемся к камере
	if is_rotating:
		global_rotation.y = lerp_angle(global_rotation.y, camera_rot, rotation_speed * delta)
		
		# Останавливаем анимацию вращения, когда почти довернулись (порог 1-2 градуса)
		if abs(angle_difference(global_rotation.y, camera_rot)) < deg_to_rad(2.0):
			is_rotating = false

func start_ik():
	spine_ik.active = true

func stop_ik():
	spine_ik.active = false

func accept_target_node(target_node: Marker3D):
	var path = spine_ik.get_path_to(target_node)
	spine_ik.set_target_node(0, path)
