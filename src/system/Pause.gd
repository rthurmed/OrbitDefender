extends CanvasLayer


onready var ui = $UI
onready var btn_continue = $UI/VBoxContainer/Continue


func _input(event):
	if event.is_action_released("pause"):
		paused(not get_tree().paused)


func paused(state: bool):
	get_tree().paused = state
	ui.visible = state
	
	if ui.visible:
		btn_continue.grab_focus()


func _on_Continue_pressed():
	paused(false)


func _on_Restart_pressed():
	paused(false)
	var _ok = get_tree().reload_current_scene()
