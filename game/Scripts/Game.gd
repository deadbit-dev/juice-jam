extends Node

signal gameover
signal win

export (PackedScene) var Hero
export (PackedScene) var Enemy

onready var win_timer = $WinTimer
onready var spawn_timer = $SpawnTimer
onready var hud = $HUD
onready var camera = $ShakeCamera
onready var hero_start_pos = $StartHero.position

var Player: KinematicBody2D


func _ready():
	win_timer.connect("timeout", self, "win")
	spawn_timer.connect("timeout", self, "spawn_enemy")
	hud.connect("game", self, "start_game")


func start_game():
	randomize()
	spawn_player()
	win_timer.start()
	spawn_timer.start()


func game_over():
	win_timer.stop()
	spawn_timer.stop()
	get_tree().call_group("enemies", "queue_free")
	emit_signal("gameover")


func win():
	spawn_timer.stop()
	get_tree().call_group("enemies", "queue_free")
	Player.queue_free()
	emit_signal("win")


func spawn_player():
	Player = Hero.instance()
	Player.connect("died", self, "game_over")
	Player.position = hero_start_pos
	Player.purpose = hero_start_pos
	add_child(Player)


func spawn_enemy():
	var enemy = Enemy.instance()
	enemy.position = rand_pos_on_rect_edge(get_viewport().size)
	enemy.connect("shake", camera, "shake_on")
	add_child(enemy)
	enemy.attack(Player)


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
