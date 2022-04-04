extends Node2D


export var min_altitude = 32
export var max_altitude = 128
export var v_move_speed = 20

onready var animation = $RotatoryAxis/Spaceship/AnimationPlayer
onready var visual_instance = $RotatoryAxis/Spaceship/VisualInstance
onready var ship_sprite = $RotatoryAxis/Spaceship/VisualInstance/Sprite
onready var ship = $RotatoryAxis/Spaceship
onready var gun = $RotatoryAxis/Spaceship/VisualInstance/Gun
onready var rotatory_axis = $RotatoryAxis

signal inverting(inverted)


# TODO: Implement bombs
# TODO: Implement ammo
# TODO: Implement damages


func _process(delta):
	# Shooting logic
	gun.shooting = Input.is_action_pressed("shoot")
	
	# Switch between clockwise and counter-clockwise
	if (
		not animation.is_playing() and
		Input.is_action_just_pressed("invert")
	):
		animation.play("deinvert" if is_inverted() else "invert")
		emit_signal("inverting", is_inverted())
	
	# Move up and down
	if (
		Input.is_action_pressed("higher") or
		Input.is_action_pressed("lower")
	):
		var move_x = (
			Input.get_action_strength("higher") -
			Input.get_action_strength("lower")
		)
		var target_position_x = clamp(ship.position.x + move_x, min_altitude, max_altitude)
		ship.position.x = lerp(ship.position.x, target_position_x, delta * v_move_speed)


func is_inverted():
	return rotatory_axis.target_speed > 0
