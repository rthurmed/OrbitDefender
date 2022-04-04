extends Area2D
class_name Asteroid


export var destination: Vector2 = Vector2.ZERO
export var move_duration = 10
export var rotate_speed = 2

onready var visual_instance = $VisualInstance
onready var auto_move_module = $AutoMoveModule


func _ready():
	auto_move_module.duration = move_duration
	auto_move_module.set_destination(destination)


func _process(delta):
	visual_instance.rotation = lerp(
		visual_instance.rotation,
		visual_instance.rotation + deg2rad(30),
		delta * rotate_speed
	)
