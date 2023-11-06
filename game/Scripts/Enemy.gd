extends RigidBody2D

signal shake
signal enemy_die

export (Vector2) var impulse = Vector2(350, 350)
export (int) var health = 3

onready var sparks = $Sparks
onready var animation = $AnimationPlayer
onready var attack_delay_timer = $AttackDelayTimer


func _ready():
	connect("body_entered", self, "on_collision")
	animation.connect("animation_finished", self, "on_animation_end")


func on_collision(body):
	if "player" in body.get_groups():
		get_tree().call_group("enemies", "queue_free")
		body.die()
	else:
		if not health:
			die()
		elif health == 2:
			animation.play("change_stage")
		sparks_effect()
		health -= 1
		emit_signal("shake")


func attack(purpose):
	attack_delay_timer.connect("timeout", self, "on_attack", [purpose])
	attack_delay_timer.start()


func on_attack(purpose):
	collision_mask = 0b11
	var direction = position.direction_to(purpose.position).normalized()
	var velocity = direction * impulse
	apply_central_impulse(velocity)


func die(fast_die = false):
	if not fast_die:
		animation.play("die")
		emit_signal("shake")
	else:
		on_die_end()


func on_animation_end(anim_name):
	if anim_name == "die":
		on_die_end()


func on_die_end():
	emit_signal("enemy_die")
	queue_free()


func sparks_effect():
	sparks.emitting = true
