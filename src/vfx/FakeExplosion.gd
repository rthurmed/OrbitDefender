extends Node2D


var Explosion = preload("res://src/vfx/Explosion.tscn")


func blast():
	var inst = Explosion.instance()
	inst.global_position = global_position
	get_tree().current_scene.call_deferred("add_child", inst)
