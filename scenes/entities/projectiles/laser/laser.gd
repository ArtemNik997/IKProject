extends Projectile
class_name LaserSmall

# Не дублируем при запуске, а создаем уникальный материал при установке цвета
func set_emission_color(color : Color) -> void:
	var mesh_node = $Mesh
	
	var mat = mesh_node.get_active_material(0)
	if mat:
		mat = mat.duplicate()
	else:
		mat = StandardMaterial3D.new()
	
	mat.emission_enabled = true
	mat.emission = color
	mat.emission_energy_multiplier = 200.0 
	
	mesh_node.set_surface_override_material(0, mat)
