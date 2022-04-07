extends CanvasLayer


export var ship_path: NodePath
export var bonus_generator_path: NodePath

onready var ship = get_node(ship_path)
onready var bonus_generator = get_node(bonus_generator_path)
onready var progress_label = $Shell/Progress/Label
onready var progress_bar = $Shell/Progress/ProgressBar
onready var bonus_label = $Shell/Bonus/Label
onready var bomb_count_label = $Shell/Indicators/BombCount/Label
onready var boost_count_label = $Shell/Indicators/BoostCount/Label


# TODO: show portrait


func _ready():
	ship.connect("updated_bomb_count", self, "_on_Ship_updated_bomb_count")
	set_bomb_count(ship.bomb_count)
	set_bonus_progress(bonus_generator.get_percent() * 100)
	set_general_progress(31)


func _process(_delta):
	set_bonus_progress(bonus_generator.get_percent() * 100)


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


func set_boost_count(count):
	boost_count_label.text = str(count)


func _on_Ship_updated_bomb_count(amount):
	set_bomb_count(amount)
