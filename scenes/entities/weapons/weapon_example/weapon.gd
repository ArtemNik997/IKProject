extends Node3D
class_name Weapon

@export var aim_target : Marker3D

@export var recoil_pos_strength : float = 0.15
@export var recoil_rot_strength : float = 15.0
@export var return_speed : float = 20.0
@export var weapon_skin : Node3D

var target_pos : Vector3 = Vector3.ZERO
var target_rot : Quaternion = Quaternion.IDENTITY
var weapon_visible: bool = false

@onready var default_pos : Vector3 = self.transform.origin
@onready var default_rot : Quaternion = self.transform.basis.get_rotation_quaternion()
#@onready var animation_player : AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	PlayerEvents.on_player_shot.connect(apply_recoil)
	#PlayerEvents.on_player_shot.connect(play_shoot_animation)
	PlayerEvents.on_aim_start.connect(set_weapon_visible)
	PlayerEvents.on_aim_stop.connect(set_weapon_invisible)

func _physics_process(delta: float) -> void:
	weapon_skin.visible = weapon_visible
	
	target_pos = target_pos.lerp(default_pos, return_speed * delta)
	target_rot = target_rot.slerp(default_rot, return_speed * delta)
	
	self.transform.origin = target_pos
	self.basis = Basis(target_rot)

func apply_recoil():
	target_pos.y += recoil_pos_strength
	
	var recoil_rotation = Quaternion(Vector3.RIGHT, -deg_to_rad(recoil_rot_strength))
	
	target_rot = target_rot * recoil_rotation

func set_weapon_visible():
	weapon_visible = true

func set_weapon_invisible():
	weapon_visible = false
