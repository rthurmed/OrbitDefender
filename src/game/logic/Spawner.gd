extends Node2D
class_name Spawner


export var enemy_scene: PackedScene
export var timer_path: NodePath

onready var timer: Timer = get_node(timer_path)

var rng = RandomNumberGenerator.new()


func _ready():
	rng.randomize()
	var _ok = timer.connect("timeout", self, "_on_Timer_timeout")


func spawn():
	# Implemented by the subclasses
	pass


func _on_Timer_timeout():
	spawn()
