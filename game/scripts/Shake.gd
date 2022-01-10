extends Camera2D

export var shake_amount = 3.5
export var time = 0.15

var is_shake = false
var elapsed_time = 0


func shake_on():
	elapsed_time = 0
	is_shake = true


func _process(delta):
	if is_shake:
		shake(delta)


func shake(delta):
	if elapsed_time < time:
		set_offset(
			Vector2(rand_range(-1.0, 1.0) * shake_amount,
			rand_range(-1.0, 1.0) * shake_amount))
		elapsed_time += delta
	else:
		is_shake = false
		elapsed_time = 0
