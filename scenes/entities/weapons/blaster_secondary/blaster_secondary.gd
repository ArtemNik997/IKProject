extends Weapon
class_name BlasterSecondary

@export var weapon_slot = "secondary"
@export var projectile : PackedScene
@export var laser_emission_color : Color = Color.WHITE

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var muzzle : Marker3D = $Muzzle

var shoot_direction : Vector3 = Vector3.ZERO

func _ready() -> void:
	super._ready()
	PlayerEvents.on_weapon_switch.connect(on_weapon_switch)

func _process(delta: float) -> void:
	if is_active:
		shoot_direction = aim_target.global_position - muzzle.global_position

func on_weapon_switch(weapon_active_slot: String):
	#is_active = weapon_active_slot == weapon_slot
	print("Secondary is active: ", is_active)

func apply_recoil():
	if is_active:
		super.apply_recoil()
		animation_player.play("shoot")

func shoot_projectile() -> void:
	if not projectile:
		push_error("BlasterPrimary: Projectile scene is not assigned!")
		return
	
	var new_projectile = projectile.instantiate()
	
	new_projectile.global_transform = muzzle.global_transform
	
	new_projectile.direction = shoot_direction
	
	if new_projectile.has_method("set_emission_color"):
		new_projectile.set_emission_color(laser_emission_color)
	
	get_tree().current_scene.add_child(new_projectile)
