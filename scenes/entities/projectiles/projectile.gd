extends Area3D
class_name Projectile

@export var speed: float = 50.0
@export var max_lifetime: float = 1.0

var direction: Vector3 = Vector3.ZERO
var time_alive: float = 0.0

func _ready() -> void:
	if direction != Vector3.ZERO:
		look_at(global_transform.origin + direction, Vector3.UP)

func _physics_process(delta: float) -> void:
	time_alive += delta
	
	if time_alive > max_lifetime:
		queue_free()
		return

	if direction != Vector3.ZERO:
		global_transform.origin += direction.normalized() * speed * delta
