extends Node2D


var Bomb = preload("res://src/game/ship/Bomb.tscn")
var distance = 96


func shoot():
	var bomb = Bomb.instance()
	var destination = to_global(Vector2.UP * distance)
	bomb.global_position = global_position
	bomb.destination = destination
	get_tree().current_scene.add_child(bomb)
