extends Weapon
class_name BlasterTertiary

@export var weapon_slot = "tertiary"

func _ready() -> void:
	super._ready()
	PlayerEvents.on_weapon_switch.connect(on_weapon_switch)

func on_weapon_switch(weapon_active_slot: String):
	#is_active = weapon_active_slot == weapon_slot
	print("Tertiary is active: ", is_active)
