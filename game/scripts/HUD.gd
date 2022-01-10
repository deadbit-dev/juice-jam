extends CanvasLayer

signal game

export (String) var start = "PRESS TO START"
export (String) var gameover = "GAMEOVER\n" + start
export (String) var win = "CONGRATULATION\n" + start

onready var ctrl = $Window
onready var msg = $Window/Message
onready var gui = $"../GUI"

onready var state = $"../../GAME"


func _ready():
	ctrl.connect("mouse_click", self, "gui_game")
	state.connect("gameover", self, "gui_gameover")
	state.connect("win", self, "gui_win")
	gui_start()


func gui_start():
	msg.text = start
	ctrl.visible = true


func gui_game():
	ctrl.visible = false
	gui.visible = true
	emit_signal("game")


func gui_gameover():
	msg.text = gameover
	gui.visible = false
	ctrl.visible = true


func gui_win():
	msg.text = win
	gui.visible = false
	ctrl.visible = true
