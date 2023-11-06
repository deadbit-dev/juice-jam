extends Node

#for each enemy
#	find direction between the player and enemy
#	change position of the warning around player + radius in that direction
#	rotate warning at that direction

export (int) var radius = 25

export (PackedScene) var Warning

onready var game = $"../../GAME"

var enemy_to_warning: Dictionary = {}


func _ready():
	game.connect("spawn_enemy", self, "on_spawn_enemy")


func on_spawn_enemy(enemy):
	enemy.connect("enemy_die", self, "on_enemy_die", [enemy])
	var warning = Warning.instance()
	enemy_to_warning[enemy] = warning
	game.add_child(warning)


func on_enemy_die(enemy):
	if not enemy_to_warning.has(enemy):
		return
	enemy_to_warning[enemy].queue_free()
	enemy_to_warning.erase(enemy)


func _process(delta):
	if not is_instance_valid(game.player):
		return
	for enemy in game.enemies:
		if not is_instance_valid(enemy) or not enemy_to_warning.has(enemy):
			continue
		var direction = (enemy.position - game.player.position).normalized()
		var warning = enemy_to_warning[enemy]
		warning.position = game.player.position + (direction * radius)
		warning.look_at(enemy.position)
		warning.rotation_degrees += 90
