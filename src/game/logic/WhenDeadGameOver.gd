extends Node


export var ship_path: NodePath
export var state_ui_path: NodePath

onready var ship = get_node(ship_path)
onready var state_ui = get_node(state_ui_path)


func _ready():
	ship.connect("died", self, "_on_Ship_died")


func _on_Ship_died():
	state_ui.call_game_over()
