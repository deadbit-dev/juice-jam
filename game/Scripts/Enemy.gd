extends RigidBody2D

signal shake
export (Vector2) var impulse = Vector2(350, 350)
export (int) var health = 3

onready var _animation_enemy = $AnimationPlayer
onready var _sparks = $Sparks

func _ready():
	connect("body_entered", self, "on_collision")


func on_collision(body):
	if "player" in body.get_groups():
		body.die()
	else:
		if not health:
			die()
		elif health == 2:
			_animation_enemy.play("change_stage")
		_sparks.emitting = true
		health -= 1
		emit_signal("shake")


func attack(purpose):
	var direction = position.direction_to(purpose.position).normalized()
	var velocity = direction * impulse
	apply_central_impulse(velocity)


func die():
	_animation_enemy.play("die")
	emit_signal("shake")
