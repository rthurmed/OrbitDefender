extends Node2D


func _on_BattleStagesManager_ended():
	yield(get_tree().create_timer(2), "timeout")
	var _ok = get_tree().change_scene("res://src/levels/Outro.tscn")
