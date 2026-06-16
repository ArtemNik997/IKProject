extends Area3D
class_name Projectile

@export var speed: float = 50.0
@export var max_lifetime: float = 1.0
@export var damage: float = 10.0 # Добавим урон, чтобы передавать его в метод

var direction: Vector3 = Vector3.ZERO
var time_alive: float = 0.0

func _ready() -> void:
	if direction != Vector3.ZERO:
		look_at(global_transform.origin + direction, Vector3.UP)
	
	# Подключаем сигналы столкновения динамически
	body_entered.connect(_on_collision)
	area_entered.connect(_on_collision)

func _physics_process(delta: float) -> void:
	time_alive += delta
	
	if time_alive > max_lifetime:
		queue_free()
		return

	if direction != Vector3.ZERO:
		global_transform.origin += direction.normalized() * speed * delta

# Универсальная функция для обработки столкновений
func _on_collision(target: Node) -> void:
	# Проверяем, есть ли у объекта, с которым столкнулись, метод take_damage
	if target.has_method("take_damage"):
		target.take_damage() # Вызываем метод и передаем урон
	
	# Уничтожаем снаряд после столкновения
	queue_free()
