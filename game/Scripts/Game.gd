extends Node

signal start
signal game
signal gameover
signal spawn_enemy

export (PackedScene) var Hero
export (PackedScene) var Enemy

export (int) var enemy_spawn_offset = 50

onready var hud = $HUD
onready var camera = $ShakeCamera
onready var point_timer = $PointTimer
onready var spawn_timer = $SpawnTimer
onready var hero_start_pos = $StartHero.position

var player: KinematicBody2D
var enemies: Array

var points: int = 0
var best_record: int = 0


func _ready():
	connect_signals()
	if OS.get_name() == "HTML5": init_sdk()
	else: start_menu()
func connect_signals():
	hud.start.connect("mouse_click", self, "start_game")
	hud.game_over.connect("mouse_click", self, "start_menu")
	point_timer.connect("timeout", self, "increase_points")
	spawn_timer.connect("timeout", self, "spawn_enemy")
func init_sdk():
	start_menu()


func start_menu():
	emit_signal("start")


func start_game():
	randomize()
	points = 0
	point_timer.start()
	spawn_timer.start()
	spawn_player()
	spawn_enemy()
	emit_signal("game")


func spawn_player():
	player = Hero.instance()
	player.connect("player_die_start", self, "on_player_die")
	player.connect("player_die_end", self, "game_over")
	player.position = hero_start_pos
	player.purpose = hero_start_pos
	add_child(player)


func on_player_die():
	point_timer.stop()
	spawn_timer.stop()
	while(not enemies.empty()):
		var enemy = enemies.pop_back()
		if not is_instance_valid(enemy):
			continue
		enemy.die(true)


func spawn_enemy():
	var enemy = Enemy.instance()
	var game_field = get_viewport().get_visible_rect().grow(enemy_spawn_offset)
	enemy.position = random_point_on_border(game_field)
	enemy.connect("shake", camera, "shake_on")
	enemy.sleeping = true
	enemies.append(enemy)
	add_child(enemy)
	emit_signal("spawn_enemy", enemy)
	enemy.attack(player)


func increase_points():
	points += 1
	if points > best_record:
		best_record = points
	point_timer.start()


func game_over():
	ads_timer.start()
	emit_signal("gameover")


func random_point_on_border(rect: Rect2) -> Vector2:
	var point = Vector2()
	var border = randi() % 4
	if border == 0:
		point.x = rand_range(rect.position.x, rect.position.x + rect.size.x)
		point.y = rect.position.y
	elif border == 1:
		point.x = rect.position.x + rect.size.x
		point.y = rand_range(rect.position.y, rect.position.y + rect.size.y)
	elif border == 2:
		point.x = rand_range(rect.position.x, rect.position.x + rect.size.x)
		point.y = rect.position.y + rect.size.y
	else:
		point.x = rect.position.x
		point.y = rand_range(rect.position.y, rect.position.y + rect.size.y)
	return point
