extends KinematicBody2D

signal die
export (int) var stop_dist = 15
export (int) var min_move_speed = 10
export (int) var max_move_speed = 100
export (Vector2) var purpose

onready var _animation_player = $AnimationPlayer


func _physics_process(delta):
	if position.distance_to(purpose) > stop_dist:
		var vector = purpose - position
		var direction = vector.normalized()
		var distance = vector.length()
		var velocity = direction * max(min_move_speed, min(max_move_speed, distance))
		move_and_collide(velocity * delta)


func _input(event):
	if event is InputEventMouseButton:
		purpose = event.position


func die():
	_animation_player.play("die")
	emit_signal("die")
