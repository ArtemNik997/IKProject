extends Node3D
class_name ActionGatherer

@export var detection_area : Area3D
@export var attack_area : Area3D
@export var enemy_globals : EnemyGlobals

var is_player_detected : bool = false
var is_player_in_attack_range : bool = false

func _ready():
	print(enemy_globals)
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

func _on_detection_entered(body: Node) -> void:
	if not body.is_in_group("player"):
		return
		
	if not body is Player:
		push_warning("Объект в группе 'player', но не является типом Player: ", body.name)
		return
		
	#if enemy_globals == null:
		#push_error("EnemyGlobals не назначен в инспекторе!")
		#return
		
	is_player_detected = true
	#enemy_globals.player = body as Player

func _on_attack_entered(body):
	if body.is_in_group("player"):
		is_player_in_attack_range = true

func _on_attack_exited(body):
	if body.is_in_group("player"):
		is_player_in_attack_range = false
