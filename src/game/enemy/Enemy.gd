extends Area2D


export var destination: Vector2 = Vector2.ZERO
export var move_duration = 6
export var aim_speed = .75

onready var auto_move_module = $AutoMoveModule
onready var targetting_module = $TargettingModule
onready var gun1 = $Gun1
onready var gun2 = $Gun2

var attacking = false


func _ready():
	auto_move_module.duration = move_duration
	auto_move_module.set_destination(destination)
	rotation = to_local(destination).angle() + deg2rad(90)


func _process(delta):
	if not attacking or targetting_module.target == null:
		return
	
	var diff_pos = targetting_module.target.global_position - global_position
	var angle_to_target = diff_pos.angle() + deg2rad(90)
	
	global_rotation = lerp_angle(global_rotation, angle_to_target, delta * aim_speed)


func _on_AutoMoveModule_completed():
	attacking = true
	targetting_module.relocate()
	gun1.set_shooting(true)
	gun2.set_shooting(true)
