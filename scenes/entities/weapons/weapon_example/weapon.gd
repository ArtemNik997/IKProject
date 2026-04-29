extends Node3D
class_name Weapon

@export var aim_target : Marker3D

@export var recoil_pos_strength : float = 0.15
@export var recoil_rot_strength : float = 15.0
@export var return_speed : float = 20.0

var target_pos : Vector3 = Vector3.ZERO
var target_rot : Quaternion = Quaternion.IDENTITY
var weapon_visible: bool = false

@onready var weapon_mesh : MeshInstance3D = $WeaponMesh
@onready var default_pos : Vector3 = weapon_mesh.transform.origin
@onready var default_rot : Quaternion = weapon_mesh.transform.basis.get_rotation_quaternion()


func _ready() -> void:
	PlayerEvents.on_player_shot.connect(apply_recoil)
	PlayerEvents.on_aim_start.connect(set_weapon_visible)
	PlayerEvents.on_aim_stop.connect(set_weapon_invisible)

func _physics_process(delta: float) -> void:
	visible = weapon_visible
	
	target_pos = target_pos.lerp(default_pos, return_speed * delta)
	target_rot = target_rot.slerp(default_rot, return_speed * delta)
	
	weapon_mesh.transform.origin = target_pos
	weapon_mesh.basis = Basis(target_rot)
	#look_at(-aim_target.global_position)

## Вызывай эту функцию в момент выстрела
func apply_recoil():
	# Смещаем позицию вверх (относительно родителя)
	target_pos.y += recoil_pos_strength
	
	# Создаем кватернион поворота (назад по оси X)
	var recoil_rotation = Quaternion(Vector3.RIGHT, -deg_to_rad(recoil_rot_strength))
	
	# Применяем отдачу к текущему вращению
	target_rot = target_rot * recoil_rotation

func set_weapon_visible():
	weapon_visible = true

func set_weapon_invisible():
	weapon_visible = false
