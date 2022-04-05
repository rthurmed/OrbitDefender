extends Node2D


const EXPLOSION_POS_NOISE = 8

export var health_points = 10
export var main_node_path: NodePath
export var override_death = false
export var override_sound = false
export var sound_hit: AudioStream
export var sound_death: AudioStream

onready var progress_bar = $ProgressBar
onready var explosion_delay = $ExplosionDelay
onready var audio_hit = $Audio2D/Hit
onready var audio_death = $Audio2D/Death
onready var main_node = get_node(main_node_path) if not override_death else null

var ExplosionVfx = preload("res://src/vfx/Explosion.tscn")
var can_show_explosion = true
var has_set_last_explosion = false
var has_main_node = false

signal died
signal hit(amount, hp)
signal last_explosion_peak
signal completed_death_explosion


func _ready():
	progress_bar.max_value = health_points
	progress_bar.value = health_points
	has_main_node = main_node != null
	audio_hit.set_stream(sound_hit)
	audio_death.set_stream(sound_death)


func _process(_delta):
	global_rotation = 0


func is_alive():
	return health_points > 0


func kill(pos):
	hit(health_points, pos)


func hit(amount, pos):
	# Update values
	health_points -= amount
	progress_bar.value = health_points
	
	var going_to_die = health_points <= 0
	var explosion = ExplosionVfx.instance()
	
	# Sfx
	if can_show_explosion and not override_sound:
		audio_hit.play()
	
	# Vfx
	if can_show_explosion or going_to_die:
		explosion.global_position = pos + Vector2(
			# Apply random offset to diversify the vfx
			rand_range(-EXPLOSION_POS_NOISE, EXPLOSION_POS_NOISE),
			rand_range(-EXPLOSION_POS_NOISE, EXPLOSION_POS_NOISE)
		)
		
		get_tree().current_scene.add_child(explosion)
		
		can_show_explosion = false
		explosion_delay.start()
	
	# Communicate to others
	emit_signal("hit", amount, health_points)
	if going_to_die and not has_set_last_explosion:
		emit_signal("died")
		
		explosion.notify_explosion_max = true
		explosion.connect("explosion_max", self, "_on_Last_Explosion_explosion_max")
		explosion.connect("ended", self, "_on_Last_Explosion_ended")
		
		has_set_last_explosion = true


func _on_Last_Explosion_explosion_max():
	emit_signal("last_explosion_peak")
	if not override_death and has_main_node:
		main_node.visible = false
		if not override_death and has_main_node:
			main_node.queue_free()


func _on_Last_Explosion_ended():
	# Unreacheable
	emit_signal("completed_death_explosion")


func _on_ExplosionDelay_timeout():
	can_show_explosion = true


func _on_HealthModule_died():
	if not override_sound:
		audio_death.play()
