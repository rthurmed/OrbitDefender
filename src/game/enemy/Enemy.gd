extends Area2D
class_name Enemy


export var destination: Vector2 = Vector2.ZERO
export var move_duration = 6
export var aim_speed = .75

onready var auto_move_module = $AutoMoveModule
onready var targetting_module = $TargettingModule
onready var aim_follow_module = $AimFollowModule
onready var gun1 = $Gun1
onready var gun2 = $Gun2


func _ready():
	auto_move_module.duration = move_duration
	auto_move_module.set_destination(destination)
	aim_follow_module.aim_speed = aim_speed
	rotation = to_local(destination).angle() + deg2rad(90)


func _on_AutoMoveModule_completed():
	aim_follow_module.disabled = false
	targetting_module.relocate()
	gun1.set_shooting(true)
	gun2.set_shooting(true)
