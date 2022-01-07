extends RigidBody2D

signal shake
export var impulse = Vector2(350, 350)
export var crash_stage = 3

func _ready():
	connect("body_entered", self, "on_collision")


func on_collision(body):
	if body.name == "Hero":
		body.die()
	else:
		if crash_stage == 0:
			die()
		crash_stage -= 1
		emit_signal("shake")


func attack(purpose):
	var direction = position.direction_to(purpose.position).normalized()
	var velocity = direction * impulse
	look_at(purpose.position)
	rotation_degrees += 90
	apply_central_impulse(velocity)


func die():
	emit_signal("shake")
	queue_free()
