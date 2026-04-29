extends Skeleton3D
class_name EnemySkeleton

@export var sway_amplitude: float = 0.1
@export var sway_speed: float = 2.0
@export var arm_movement_amplitude: float = 0.15
@export var arm_movement_speed: float = 1.5
@export var noise_seed: int = 12345

# Hand targets
@onready var r_arm_marker = $TargetsIK/r_arm_marker
@onready var l_arm_marker = $TargetsIK/l_arm_marker

var time: float = 0.0
var noise: FastNoiseLite

# Начальные позиции маркеров
var r_arm_initial_pos: Vector3
var l_arm_initial_pos: Vector3

func _ready():
	# Инициализация генератора шума
	noise = FastNoiseLite.new()
	noise.seed = noise_seed
	noise.frequency = 0.5
	noise.fractal_octaves = 2
	noise.fractal_lacunarity = 2.0
	noise.fractal_gain = 0.5
	
	# Сохраняем начальные позиции маркеров
	if r_arm_marker:
		r_arm_initial_pos = r_arm_marker.position
	if l_arm_marker:
		l_arm_initial_pos = l_arm_marker.position

func _process(delta):
	time += delta
	random_hands_movement(delta)

func random_hands_movement(delta: float):
	"""Процедурное движение руками с помощью шума"""
	if not r_arm_marker or not l_arm_marker:
		return
	
	# Генерируем плавные случайные значения через шум
	var noise_time = time * arm_movement_speed
	
	# Правая рука - используем разные смещения для каждой оси
	var r_noise_x = noise.get_noise_1d(noise_time + 1000)
	var r_noise_y = noise.get_noise_1d(noise_time + 2000)
	var r_noise_z = noise.get_noise_1d(noise_time + 3000)
	
	# Левая рука - другие смещения для независимого движения
	var l_noise_x = noise.get_noise_1d(noise_time + 4000)
	var l_noise_y = noise.get_noise_1d(noise_time + 5000)
	var l_noise_z = noise.get_noise_1d(noise_time + 6000)
	
	# Применяем смещения к маркерам относительно начальной позиции
	r_arm_marker.position = r_arm_initial_pos + Vector3(
		r_noise_x * arm_movement_amplitude,
		r_noise_y * arm_movement_amplitude * 0.5,  # Меньше движение по Y
		r_noise_z * arm_movement_amplitude
	)
	
	l_arm_marker.position = l_arm_initial_pos + Vector3(
		l_noise_x * arm_movement_amplitude,
		l_noise_y * arm_movement_amplitude * 0.5,
		l_noise_z * arm_movement_amplitude
	)
