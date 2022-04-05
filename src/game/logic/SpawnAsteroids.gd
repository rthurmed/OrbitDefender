extends Node2D


export var distance_noise = 16
export var distance_start = 256

var Asteroid = preload("res://src/game/asteroid/Asteroid.tscn")
var AsteroidLarge = preload("res://src/game/asteroid/AsteroidLarge.tscn")
var asteroid_types = [Asteroid, AsteroidLarge]
var rng = RandomNumberGenerator.new()


func _ready():
	rng.randomize()
	spawn()


func spawn():
	var angle = deg2rad(rng.randf_range(0, 360))
	var pos_noise = rng.randi_range(-distance_noise, distance_noise)
	var asteroid_position = Vector2.RIGHT * (distance_start + pos_noise)
	asteroid_position = asteroid_position.rotated(angle)
	asteroid_position = to_global(asteroid_position)
	
	var asteroid
	
	# Easier to be a small asteroid
	if rng.randf() > 0.3:
		asteroid = Asteroid.instance()
	else:
		asteroid = AsteroidLarge.instance()
	
	asteroid.global_position = asteroid_position
	get_tree().current_scene.call_deferred("add_child", asteroid)


func _on_Timer_timeout():
	spawn()
