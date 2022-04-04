extends Node2D


const DEFAULT_SPEED = deg2rad(-32)

export var accel = 3
export var turn_speed = 0.5

var speed = DEFAULT_SPEED
var target_speed = DEFAULT_SPEED

signal full360


func _process(delta):
	speed = lerp_angle(speed, target_speed, delta * turn_speed)
	rotation = lerp_angle(rotation, rotation + speed, delta * accel)
	
	if rotation > deg2rad(360):
		rotation -= deg2rad(360)
		emit_signal("full360")
	
	if rotation < deg2rad(-360):
		rotation += deg2rad(360)
		emit_signal("full360")


func _on_Ship_inverting(_inverted):
	target_speed = target_speed * -1
