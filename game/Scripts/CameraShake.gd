extends Camera2D

export var camera_shake_amount = 1.5
export var timeShake = 0.2
var elapsedtime = 0


func _process(delta):
	shake(delta)


func shake_on():
	elapsedtime = timeShake


func shake(delta):
	if elapsedtime > 0:
		set_offset(Vector2( \
			rand_range(-1.0, 1.0) * camera_shake_amount, \
			rand_range(-1.0, 1.0) * camera_shake_amount \
		))
		elapsedtime -= delta
