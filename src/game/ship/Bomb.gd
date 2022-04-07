extends Area2D


export var destination = Vector2.ZERO

onready var auto_move_module = $AutoMoveModule
onready var animation = $AnimationPlayer
onready var impact_attack_module = $ImpactZone/ImpactAttackModule

var target_group = 'enemy'
var exploded = false


func _ready():
	auto_move_module.set_destination(destination)
	impact_attack_module.target_group = target_group
	global_rotation = to_local(destination).angle() + deg2rad(90)


func _on_AutoMoveModule_completed():
	if exploded: return
	animation.play("explode")
	exploded = true


func _on_Bomb_area_entered(area):
	if exploded: return
	if not area.is_in_group(target_group):
		return
	auto_move_module.cancel_move()
	animation.play("explode")
	exploded = true


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "explode":
		queue_free()
