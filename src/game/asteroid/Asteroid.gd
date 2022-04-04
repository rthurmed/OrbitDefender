extends Area2D


export var rotate_speed = 2
export var move_speed = 4

onready var sprite = $Sprite


func _process(delta):
	position = lerp(position, position + Vector2.RIGHT, delta * move_speed)
	sprite.rotation = lerp(sprite.rotation, sprite.rotation + deg2rad(30), delta * rotate_speed)
