extends Node2D


onready var animation = $AnimationPlayer


func _ready():
	animation.play("intro")


func _unhandled_input(event):
	if event.is_action_released("skip"):
		go_to_next_scene()


func go_to_next_scene():
	var _ok = get_tree().change_scene("res://src/levels/Main.tscn")


func _on_AnimationPlayer_animation_finished(_anim_name):
	go_to_next_scene()
