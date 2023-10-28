extends MarginContainer

export var dt = 20.0

onready var bar = $Bars/TimerBar/Progress
onready var points = $Bars/TimerBar/Points
onready var point_timer = $"../PointTimer"
onready var game = $"../../GAME"


func _ready():
	bar.max_value = point_timer.wait_time * dt


func _process(delta):
	bar.value = point_timer.time_left * dt
	points.text = String(game.points)
