extends Node2D


export var destination: Vector2 = Vector2.ZERO
export var chance_heal: float = 0.4
export var chance_bomb: float = 0.3
export var chance_turret: float = 0.3

onready var timer = $Timer

var FlyingBonusPickup = preload("res://src/game/bonus/FlyingBonusPickup.tscn")


func get_percent():
	return Util.timer_percent(timer)


func spawn():
	var inst = FlyingBonusPickup.instance()
	inst.destination = destination
	
	var type_value = randf()
	if type_value < chance_heal:
		inst.type = Enum.BonusType.HEAL
	elif type_value < chance_heal + chance_bomb:
		inst.type = Enum.BonusType.BOMB
	else:
		inst.type = Enum.BonusType.TURRET
	
	get_tree().current_scene.call_deferred("add_child", inst)


func _on_Timer_timeout():
	spawn()
