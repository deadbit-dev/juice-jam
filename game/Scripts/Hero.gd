extends KinematicBody2D

signal die
export var stop_dist = 15
export var min_move_speed = 10
export var max_move_speed = 100

var purpose = position


func _physics_process(delta):
	look_at(get_global_mouse_position())
	rotation_degrees += 90
	
	if position.distance_to(purpose) > stop_dist:
		var vector = purpose - position
		var direction = vector.normalized()
		var distance = vector.length()
		var velocity = direction * max(min_move_speed, min(max_move_speed, distance))
		move_and_collide(velocity * delta)


func _input(event):
	if event is InputEventMouseButton:
		purpose = event.position


func born(pos):
	position = pos
	purpose = pos
	show()


func die():
	hide()
	emit_signal("die")
