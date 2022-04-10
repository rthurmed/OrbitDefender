extends Node


export var target_node_path: NodePath
export var state_ui_path: NodePath
export var stage_manager_path: NodePath
export var message = "you died!"

onready var target_node = get_node(target_node_path)
onready var state_ui = get_node(state_ui_path)
onready var stage_manager =get_node(stage_manager_path)


func _ready():
	var trigger = "died" if target_node.has_signal("died") else "tree_exited"
	target_node.connect(trigger, self, "_on_TargetNode_exited")


func _on_TargetNode_exited():
	state_ui.call_game_over(message)
	stage_manager.stop()
