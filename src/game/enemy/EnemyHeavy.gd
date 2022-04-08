extends Enemy


onready var gun3 = $Gun3


func _on_AutoMoveModule_completed():
	aim_follow_module.disabled = false
	targetting_module.relocate()
	gun1.set_shooting(true)
	gun2.set_shooting(true)
	gun3.set_shooting(true)
