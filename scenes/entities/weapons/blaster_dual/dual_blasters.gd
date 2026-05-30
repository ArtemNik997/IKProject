extends Weapon
class_name DualBlasters

@export var weapon_slot = "tertiary"
@onready var animation_player : AnimationPlayer = $AnimationPlayer

#@onready var rh_target : Marker3D = $"RHPivot/blaster-b2/RHTarget"
#@onready var lh_target : Marker3D = $"LHPivot/blaster-c2/LHTarget"

func _ready() -> void:
	super._ready()
	rh_target = $"Pivot/RHPivot/blaster-b2/RHTarget"
	lh_target = $"Pivot/LHPivot/blaster-c2/LHTarget"
	PlayerEvents.on_weapon_switch.connect(on_weapon_switch)

func on_weapon_switch(weapon_active_slot: String):
	#is_active = weapon_active_slot == weapon_slot
	print("Dual Blasters are active: ", is_active)

func apply_recoil():
	animation_player.play("shoot")
