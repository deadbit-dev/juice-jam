extends CanvasLayer

signal game

onready var start = $Start
onready var game_over = $GameOver
onready var win = $Win
onready var gui = $"../GUI"

onready var state = $"../../GAME"


func _ready():
	start.connect("mouse_click", self, "gui_game")
	game_over.connect("mouse_click", self, "gui_start")
	win.connect("mouse_click", self, "gui_start")
	state.connect("gameover", self, "gui_gameover")
	state.connect("win", self, "gui_win")
	gui_start()


func gui_start():
	gui.pause_mode = Node.PAUSE_MODE_STOP
	gui.visible = false
	game_over.pause_mode = Node.PAUSE_MODE_STOP
	game_over.visible = false
	win.pause_mode = Node.PAUSE_MODE_STOP
	win.visible = false
	start.pause_mode = Node.PAUSE_MODE_PROCESS
	start.visible = true


func gui_game():
	start.pause_mode = Node.PAUSE_MODE_STOP
	start.visible = false
	game_over.pause_mode = Node.PAUSE_MODE_STOP
	game_over.visible = false
	win.pause_mode = Node.PAUSE_MODE_STOP
	win.visible = false
	gui.pause_mode = Node.PAUSE_MODE_PROCESS
	gui.visible = true
	emit_signal("game")


func gui_gameover():
	gui.pause_mode = Node.PAUSE_MODE_STOP
	gui.visible = false
	game_over.pause_mode = Node.PAUSE_MODE_PROCESS
	game_over.visible = true


func gui_win():
	gui.pause_mode = Node.PAUSE_MODE_STOP
	gui.visible = false
	win.pause_mode = Node.PAUSE_MODE_PROCESS
	win.visible = true
