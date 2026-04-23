extends Node3D
class_name Weapon

@export var aim_target : Marker3D

# Настройки отдачи
@export var recoil_pos_strength : float = 0.15 # Сила подброса вверх
@export var recoil_rot_strength : float = 15.0 # Угол наклона в градусах
@export var return_speed : float = 20.0       # Скорость возврата

# Внутренние переменные для отслеживания состояния
var target_pos : Vector3 = Vector3.ZERO
var target_rot : Quaternion = Quaternion.IDENTITY

@onready var weapon_mesh : MeshInstance3D = $WeaponMesh
# Запоминаем исходные локальные трансформации
@onready var default_pos : Vector3 = weapon_mesh.transform.origin
@onready var default_rot : Quaternion = weapon_mesh.transform.basis.get_rotation_quaternion()


func _ready() -> void:
	PlayerEvents.on_player_shot.connect(apply_recoil)

func _physics_process(delta: float) -> void:
	# 1. Плавно возвращаем целевые значения к дефолтным (относительно родителя)
	target_pos = target_pos.lerp(default_pos, return_speed * delta)
	target_rot = target_rot.slerp(default_rot, return_speed * delta)
	
	# 2. Применяем накопленную трансформацию к мешу
	weapon_mesh.transform.origin = target_pos
	weapon_mesh.basis = Basis(target_rot)

## Вызывай эту функцию в момент выстрела
func apply_recoil():
	# Смещаем позицию вверх (относительно родителя)
	target_pos.y += recoil_pos_strength
	
	# Создаем кватернион поворота (назад по оси X)
	var recoil_rotation = Quaternion(Vector3.RIGHT, -deg_to_rad(recoil_rot_strength))
	
	# Применяем отдачу к текущему вращению
	target_rot = target_rot * recoil_rotation
