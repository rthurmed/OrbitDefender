extends Spawner


export var distance_to_shoot = 88
export var distance_noise = 16
export var distance_start = 192
export var start_degress_range = 30


func spawn():
	var shoot_angle = deg2rad(rng.randf_range(0, 360))
	var shoot_pos_noise = rng.randi_range(-distance_noise, distance_noise)
	var shoot_position = Vector2.RIGHT * (distance_to_shoot + shoot_pos_noise)
	shoot_position = shoot_position.rotated(shoot_angle)
	shoot_position = to_global(shoot_position)
	
	# Start position is derived from shoot position
	# The enemy is spawned at start but moves to shooting position
	var start_angle = deg2rad(rng.randf_range(-start_degress_range, start_degress_range))
	var start_pos_noise = rng.randi_range(-distance_noise, distance_noise)
	var start_position = Vector2.RIGHT * (distance_start + start_pos_noise)
	start_position = start_position.rotated(shoot_angle + start_angle)
	start_position = shoot_position + start_position
	
	var enemy = enemy_scene.instance()
	enemy.global_position = start_position
	enemy.destination = shoot_position
	get_tree().current_scene.call_deferred("add_child", enemy)
