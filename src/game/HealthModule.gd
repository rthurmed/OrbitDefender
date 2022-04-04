extends Node2D


const EXPLOSION_POS_NOISE = 8

export var health_points = 10
export var main_node_path: NodePath
export var override_death = false

onready var progress_bar = $ProgressBar
onready var explosion_delay = $ExplosionDelay
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


func _process(_delta):
	global_rotation = 0


func is_alive():
	return health_points > 0


func hit(amount, pos):
	# Update values
	health_points -= amount
	progress_bar.value = health_points
	
	var going_to_die = health_points <= 0
	var explosion = ExplosionVfx.instance()
	
	# Vfx
	if can_show_explosion or going_to_die:
		explosion.global_position = pos + Vector2(
			# Apply random offset to diversify the vfx
			rand_range(-EXPLOSION_POS_NOISE, EXPLOSION_POS_NOISE),
			rand_range(-EXPLOSION_POS_NOISE, EXPLOSION_POS_NOISE)
		)
		
		get_tree().root.add_child(explosion)
		
		can_show_explosion = false
		explosion_delay.start()
	
	# Communicate to others
	emit_signal("hit", amount, health_points)
	if going_to_die:
		emit_signal("died")
		
		if not has_set_last_explosion:
			explosion.connect("explosion_max", self, "_on_Last_Explosion_explosion_peak")
			explosion.connect("ended", self, "_on_Last_Explosion_ended")
			has_set_last_explosion = true


func _on_Last_Explosion_explosion_max():
	emit_signal("last_explosion_peak")
	if not override_death and has_main_node:
		main_node.visible = false


func _on_Last_Explosion_ended():
	emit_signal("completed_death_explosion")
	if not override_death and has_main_node:
		main_node.queue_free()


func _on_ExplosionDelay_timeout():
	can_show_explosion = true
