extends Node3D
class_name TargetHolder

@export var spawn_scene: PackedScene

@export var spawn_interval: float = 1.0
@export var max_spawn_num: int = 5
@export var height_offset: float = 0.5
@export var min_distance: float = 0.5

@onready var collision_shape: CollisionShape3D = $Area3D/CollisionShape3D

var active_targets: Array[Node3D] = []
var spawn_timer: Timer

func _ready() -> void:
	if spawn_interval > 0 and spawn_scene:
		spawn_timer = Timer.new()
		spawn_timer.wait_time = spawn_interval
		spawn_timer.autostart = true
		spawn_timer.timeout.connect(_on_spawn_timer_timeout)
		add_child(spawn_timer)

func _on_spawn_timer_timeout() -> void:
	active_targets = active_targets.filter(func(target): return is_instance_valid(target))
	
	if active_targets.size() >= max_spawn_num:
		return

	spawn_object()

func spawn_object() -> void:
	if not spawn_scene:
		push_warning("No spawn objects!")
		return

	var box_shape = collision_shape.shape as BoxShape3D
	if not box_shape:
		push_error("CollisionShape3D must be BoxShape3D!")
		return

	var half_size = box_shape.size / 2.0
	var global_spawn_position: Vector3
	var valid_position = false
	
	for attempt in 30:
		var random_x = randf_range(-half_size.x, half_size.x)
		var random_z = randf_range(-half_size.z, half_size.z)
		var local_offset = Vector3(random_x, height_offset, random_z)
		var potential_pos = global_transform * local_offset
		
		var too_close = false
		for target in active_targets:
			if potential_pos.distance_to(target.global_position) < min_distance:
				too_close = true
				break
				
		if not too_close:
			global_spawn_position = potential_pos
			valid_position = true
			break

	if not valid_position:
		return

	var new_instance = spawn_scene.instantiate() as Node3D
	add_child(new_instance)
	new_instance.global_position = global_spawn_position
	active_targets.append(new_instance)
