extends Node2D


export var health_points = 10

onready var progress_bar = $ProgressBar

signal died
signal hit(amount, hp)


func _ready():
	progress_bar.max_value = health_points
	progress_bar.value = health_points


func _process(_delta):
	global_rotation = 0


func is_alive():
	return health_points > 0


func hit(amount):
	health_points -= amount
	progress_bar.value = health_points
	emit_signal("hit", amount, health_points)
	if health_points <= 0:
		emit_signal("died")
