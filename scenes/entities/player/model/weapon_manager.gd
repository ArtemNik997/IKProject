extends Node
class_name WeaponManager

@export var aim_target : Marker3D
@export var weapon_slots : Dictionary[String, Weapon]

var active_weapon : Weapon

func _ready() -> void:
	PlayerEvents.on_weapon_switch.connect(switch_weapon)
	PlayerEvents.on_player_shot.connect(shoot_active_weapon)

	for weapon in weapon_slots:
		weapon_slots[weapon].aim_target = aim_target
	pass

func switch_weapon(weapon_name: String):
	if active_weapon:
		if weapon_slots[weapon_name] == active_weapon:
			return
	
	if not weapon_slots.has(weapon_name):
		return
	for weapon in weapon_slots:
		weapon_slots[weapon].is_active = false
	
	active_weapon = weapon_slots[weapon_name]
	active_weapon.is_active = true
	PlayerGlobals.player_current_weapon = active_weapon
	print("Switching weapon to: ", PlayerGlobals.player_current_weapon.name)
	pass

func shoot_active_weapon():
	active_weapon.apply_recoil()
