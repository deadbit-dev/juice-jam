extends Node

signal start
signal game
signal gameover

export (PackedScene) var Hero
export (PackedScene) var Enemy

onready var hud = $HUD
onready var camera = $ShakeCamera
onready var point_timer = $PointTimer
onready var spawn_timer = $SpawnTimer
onready var hero_start_pos = $StartHero.position

var player: KinematicBody2D
var enemies: Array

var points: int = 0
var best_record: int = points


func _ready():
	hud.start.connect("mouse_click", self, "start_game")
	hud.game_over.connect("mouse_click", self, "start_menu")
	start_menu()


func start_menu():
	emit_signal("start")


func start_game():
	randomize()	
	init_timers()
	spawn_player()
	emit_signal("game")


func init_timers():
	point_timer.connect("timeout", self, "increase_points")
	spawn_timer.connect("timeout", self, "spawn_enemy")
	point_timer.start()
	spawn_timer.start()


func spawn_player():
	player = Hero.instance()
	player.connect("died", self, "game_over")
	player.position = hero_start_pos
	player.purpose = hero_start_pos
	add_child(player)


func spawn_enemy():
	var enemy = Enemy.instance()
	enemy.position = rand_pos_on_rect_edge(get_viewport().get_visible_rect().size)
	enemy.connect("shake", camera, "shake_on")
	enemies.append(enemy)
	add_child(enemy)
	enemy.attack(player)


func increase_points():
	points += 1
	if points > best_record:
		best_record = points
	point_timer.start()


func game_over():
	point_timer.stop()
	spawn_timer.stop()
	player.queue_free()
	get_tree().call_group("enemies", "queue_free")
	emit_signal("gameover")


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
