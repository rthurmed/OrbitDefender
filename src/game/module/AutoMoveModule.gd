extends Node2D


export var node_path: NodePath
export var destination: Vector2 = Vector2.ZERO
export var move_on_ready = false
export var duration: float = 2.0
export var delay = 0

onready var node: Node2D = get_node(node_path)
onready var tween = $Tween

signal completed


func _ready():
	if move_on_ready:
		set_destination(destination)


func set_destination(dest):
	destination = dest
	tween.stop_all()
	tween.interpolate_property(
		node,
		"global_position",
		node.global_position,
		destination,
		duration,
		Tween.TRANS_CUBIC,
		Tween.EASE_OUT,
		delay
	)
	tween.start()


func cancel_move():
	tween.stop_all()


func _on_Tween_tween_all_completed():
	emit_signal("completed")
