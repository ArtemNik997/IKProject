extends Node3D
class_name ActionGatherer

@export var detection_area : Area3D
@export var attack_area : Area3D

var new_action : ActionPackage = ActionPackage.new()

func _ready():
	new_action.actions.append("wander")
	if detection_area == null or attack_area == null:
		assert("Detection area is null:", str(detection_area == null))
		assert("Attack area is null:",  str(attack_area == null))
		return
	detection_area.body_entered.connect(_on_body_detected)
	attack_area.body_entered.connect(_on_body_to_attack_entered)
	#attack_area.body_entered.connect(_on_body_to_attack_exited)

func gather_action() -> ActionPackage:
	if new_action.actions.size() > 100:
		var last_action = new_action.actions.back()
		new_action.actions.clear()
		new_action.actions.append(last_action)
	return new_action

func _on_body_detected(body: Node3D):
	print("Body detected")
	if body.is_in_group("player"):
		new_action.actions.append("chase")
		print("Player entered")

func _on_body_to_attack_entered(body: Node3D):
	if body.is_in_group("player"):
		new_action.actions.append("attack")
		new_action.actions.append("chase")
		print("Player entered")

#func _on_body_to_attack_exited(body: Node3D):
	#if body.is_in_group("player"):
		#new_action.actions.append("chase")
		#print("Player entered")
