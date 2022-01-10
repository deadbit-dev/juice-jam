extends MarginContainer

export var dt = 20.0

onready var bar = $Bars/TimerBar/Progress
onready var count = $Bars/TimerBar/Time
onready var timer = $"../WinTimer"
onready var tween = $Tween


func _ready():
	var win_time = timer.wait_time
	bar.max_value = win_time * dt


func _process(delta):
	var time_left = timer.time_left
	count.text =  "00:" + String(int(time_left))
	bar.value = time_left * dt
