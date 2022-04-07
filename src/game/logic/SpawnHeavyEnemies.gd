extends SpawnEnemies


var EnemyHeavy = preload("res://src/game/enemy/EnemyHeavy.tscn")


func _on_Timer_timeout():
	spawn(EnemyHeavy)
