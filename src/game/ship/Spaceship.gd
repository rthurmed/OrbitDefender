extends KinematicBody2D


const MIN_ALTITUDE = 32
const MAX_ALTITUDE = 128

export var v_move_speed = 20

onready var animation = $AnimationPlayer
onready var visual_instance = $VisualInstance
onready var ship_sprite = $VisualInstance/Sprite
onready var rotatory_axis = $".."

signal inverting(inverted)


func _process(delta):
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
		var target_position_x = clamp(position.x + move_x, MIN_ALTITUDE, MAX_ALTITUDE)
		position.x = lerp(position.x, target_position_x, delta * v_move_speed)


func is_inverted():
	return rotatory_axis.target_speed > 0


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "invert":
		pass
