extends Node
class_name NPCVelocityCalculator

@export var npc: CharacterBody3D
@export var animation_player: AnimationPlayer
@export var root_motion_scale: float = 1.0

# Внутренние данные для управления анимацией
var _target_direction: Vector3 = Vector3.ZERO
var _target_speed: float = 0.0

func _physics_process(delta: float) -> void:
	if npc == null or animation_player == null:
		return

	# 🎬 Получаем дельту перемещения из анимации.
	# Godot уже учитывает delta и скорость воспроизведения.
	var root_motion_transform = animation_player.get_root_motion_delta()
	var anim_velocity = root_motion_transform.origin * root_motion_scale

	# 🧍 Применяем к CharacterBody3D
	npc.velocity = anim_velocity
	npc.move_and_slide()

# 📥 Метод для передачи направления и скорости извне
func set_movement_data(direction: Vector3, speed: float) -> void:
	_target_direction = direction
	_target_speed = speed
	
	# ⚠️ ВАЖНО: При Root Motion не меняем npc.velocity вручную!
	# Вместо этого здесь нужно обновлять AnimationTree или параметры AnimationPlayer,
	# чтобы анимация подстраивалась под нужную скорость/направление.
	_update_animation_playback()

func _update_animation_playback() -> void:
	if animation_player == null or animation_player.current_animation == "":
		return

	# Пример 1: Регулировка скорости воспроизведения анимации
	var normalized_speed = clamp(_target_speed / 3.0, 0.0, 3.0) # 3.0 = базовая скорость ходьбы в анимации
	animation_player.speed_scale = normalized_speed

	# Пример 2: Поворот персонажа в направлении движения (если нужно)
	if _target_direction.length() > 0.01:
		var target_angle = atan2(_target_direction.x, _target_direction.z)
		var current_angle = npc.rotation.y
		npc.rotation.y = lerp_angle(current_angle, target_angle, 0.2)
