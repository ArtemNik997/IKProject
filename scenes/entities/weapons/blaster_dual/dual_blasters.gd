extends Weapon
class_name DualBlasters

@export var weapon_slot = "tertiary"
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@export var projectile : PackedScene

@onready var muzzle_right : Marker3D = $Pivot/MuzzleR
@onready var muzzle_left : Marker3D = $Pivot/MarkerL

var shoot_direction_right : Vector3 = Vector3.ZERO
var shoot_direction_left : Vector3 = Vector3.ZERO

func _ready() -> void:
	super._ready()
	rh_target = $"Pivot/RHPivot/blaster-b2/RHTarget"
	lh_target = $"Pivot/LHPivot/blaster-c2/LHTarget"
	PlayerEvents.on_weapon_switch.connect(on_weapon_switch)

func _process(delta: float) -> void:
	if is_active:
		shoot_direction_right = aim_target.global_position - muzzle_right.global_position
		shoot_direction_left = aim_target.global_position - muzzle_left.global_position

func on_weapon_switch(weapon_active_slot: String):
	#is_active = weapon_active_slot == weapon_slot
	print("Dual Blasters are active: ", is_active)

func apply_recoil():
	if is_active:
		animation_player.play("shoot")

func shoot_blaster_right():
	shoot_projectile(muzzle_right, shoot_direction_right)

func shoot_blaster_left():
	shoot_projectile(muzzle_left, shoot_direction_left)

func shoot_projectile(muzzle : Marker3D, shoot_direction : Vector3) -> void:
	if not projectile:
		push_error("BlasterPrimary: Projectile scene is not assigned!")
		return
	
	var new_projectile = projectile.instantiate()
	
	new_projectile.global_transform = muzzle.global_transform
	
	new_projectile.direction = shoot_direction
	
	get_tree().current_scene.add_child(new_projectile)
