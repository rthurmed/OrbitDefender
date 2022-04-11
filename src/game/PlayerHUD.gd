extends CanvasLayer


export var ship_path: NodePath
export var bonus_generator_path: NodePath
export var stages_manager_path: NodePath
export var faked = false

onready var ship = get_node(ship_path) if ship_path else null
onready var bonus_generator = get_node(bonus_generator_path) if bonus_generator_path else null
onready var stages_manager = get_node(stages_manager_path) if stages_manager_path else null
onready var progress_label = $Shell/Progress/Label
onready var progress_bar = $Shell/Progress/ProgressBar
onready var bonus_label = $Shell/Bonus/Label
onready var bomb_count_label = $Shell/Indicators/BombCount/Label
onready var turret_count_label = $Shell/Indicators/TurretCount/Label


# TODO: show portrait


func _ready():
	if faked:
		set_process(false)
		return
	ship.connect("updated_bomb_count", self, "_on_Ship_updated_bomb_count")
	ship.connect("updated_turret_count", self, "_on_Ship_updated_turret_count")
	set_bomb_count(ship.bomb_count)
	set_turret_count(ship.turret_count)
	set_bonus_progress(bonus_generator.get_percent() * 100)
	set_general_progress(stages_manager.get_percent() * 100)


func _process(_delta):
	if bonus_generator:
		set_bonus_progress(bonus_generator.get_percent() * 100)
	if stages_manager:
		set_general_progress(stages_manager.get_percent() * 100)
	


func pad_number(x: int):
	var text = "%3d" % x
	return text.replace(" ", "~")


func set_general_progress(progress):
	progress_bar.value = progress
	progress_label.text = str(pad_number(progress), "%")


func set_bonus_progress(progress):
	bonus_label.text = str(pad_number(progress), "%")


func set_bomb_count(count):
	bomb_count_label.text = str(count)


func set_turret_count(count):
	turret_count_label.text = str(count)


func _on_Ship_updated_bomb_count(amount):
	set_bomb_count(amount)


func _on_Ship_updated_turret_count(amount):
	set_turret_count(amount)
