extends Node

export (PackedScene) var Enemy


func _ready():
	$Hero.connect("die", self, "game_over")
	$SpawnTimer.connect("timeout", self, "spawn_enemy")
	new_game()


func new_game():
	# TODO: HUD message ask about start
	randomize()
	$Hero.born($StartHero.position)
	$SpawnTimer.start()


func game_over():
	# TODO: HUD message about defeat
	$SpawnTimer.stop()
	get_tree().call_group("enemies", "die")
	new_game()


func rand_pos_on_rect_edge(size: Vector2):
	var pos: Vector2
	var width = size.x
	var height = size.y
	var point = randi() % int(width + width + height + height)
	if point < (width + height):
		if point < width:
			pos.x = point
			pos.y = 0
		else:
			pos.x = width
			pos.y = point - width
	else:
		point = point - (width + height)
		if point < width:
			pos.x = width - point
			pos.y = height
		else:
			pos.x = 0
			pos.y = height - (point - width)
	return pos


func spawn_enemy():
	var enemy = Enemy.instance()
	enemy.position = rand_pos_on_rect_edge(get_viewport().size)
	enemy.connect("shake", $Camera2D, "shake_on")
	add_child(enemy)
	enemy.attack($Hero)
