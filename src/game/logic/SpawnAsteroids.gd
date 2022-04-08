extends Spawner


export var distance_noise = 16
export var distance_start = 192
export var diverge_range = 30


func spawn():
	var angle = deg2rad(rng.randf_range(0, 360))
	var pos_noise = rng.randi_range(-distance_noise, distance_noise)
	var start_position = Vector2.RIGHT * (distance_start + pos_noise)
	start_position = start_position.rotated(angle)
	start_position = to_global(start_position)
	
	var end_angle_offset = deg2rad(rng.randf_range(-diverge_range, diverge_range))
	var end_angle = angle + deg2rad(180) + end_angle_offset
	var end_position = Vector2.RIGHT * distance_start * 2
	end_position = end_position.rotated(end_angle)
	end_position = to_global(end_position)
	
	var asteroid = enemy_scene.instance()
	asteroid.global_position = start_position
	asteroid.destination = end_position
	
	get_tree().current_scene.call_deferred("add_child", asteroid)
