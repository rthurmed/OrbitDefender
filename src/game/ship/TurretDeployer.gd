extends Node2D


var Turret = preload("res://src/game/turret/Turret.tscn")


func deploy():
	var inst = Turret.instance()
	inst.global_position = global_position
	get_tree().current_scene.call_deferred("add_child", inst)
