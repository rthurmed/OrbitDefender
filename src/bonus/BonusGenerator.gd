extends Node2D


export var destination: Vector2 = Vector2.ZERO
export var chance_heal: float = 0.3
# If is not heal then is bomb, since there are still no other working bonus

onready var timer = $Timer

var FlyingBonusPickup = preload("res://src/bonus/FlyingBonusPickup.tscn")


func get_percent():
	return Util.timer_percent(timer)


func spawn():
	var inst = FlyingBonusPickup.instance()
	inst.destination = destination
	inst.type = Enum.BonusType.HEAL if randf() < chance_heal else Enum.BonusType.BOMB
	get_tree().current_scene.call_deferred("add_child", inst)


func _on_Timer_timeout():
	spawn()
