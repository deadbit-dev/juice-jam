extends MarginContainer

onready var bar = $Bars/TimerBar/Progress
onready var tween = $Tween

# var anim_time_left = 0

func _ready():
	var win_time = $"../WinTimer".wait_time
	bar.max_value = win_time
	# if not tween.is_active():
	#	tween.start()


func _process(delta):
	var time_left = $"../WinTimer".time_left
	# tween.interpolate_property(self, "anim_time_left", anim_time_left, time_left, 0.01)
	# bar.value = anim_time_left
	bar.value = time_left
