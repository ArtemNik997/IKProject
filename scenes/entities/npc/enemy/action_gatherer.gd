extends Node3D
class_name ActionGatherer

@export var detection_area : Area3D
@export var attack_area : Area3D

var is_player_detected : bool = false
var is_player_in_attack_range : bool = false

func _ready():
	if not detection_area or not attack_area:
		push_error("Areas are not assigned in ActionGatherer!")
		return
		
	detection_area.body_entered.connect(_on_detection_entered)
	
	attack_area.body_entered.connect(_on_attack_entered)
	attack_area.body_exited.connect(_on_attack_exited)

func gather_action() -> ActionPackage:
	var new_package = ActionPackage.new()
	
	new_package.actions.append("wander")
	
	if is_player_detected:
		new_package.actions.append("chase")
	
	if is_player_in_attack_range:
		new_package.actions.append("attack")
	
	# Здесь можно добавить логику смерти, если у зомби 0 HP
	# if enemy_health <= 0: new_package.actions.append("death")

	return new_package

func _on_detection_entered(body):
	if body.is_in_group("player"):
		is_player_detected = true

func _on_attack_entered(body):
	if body.is_in_group("player"):
		is_player_in_attack_range = true

func _on_attack_exited(body):
	if body.is_in_group("player"):
		is_player_in_attack_range = false
