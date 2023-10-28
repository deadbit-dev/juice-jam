extends CanvasLayer

onready var start = $Start
onready var game_over = $GameOver
onready var points = $GameOver/CenterContainer/VBoxContainer/Points
onready var best_record = $GameOver/CenterContainer/VBoxContainer/BestRecord
onready var gui = $"../GUI"
onready var game = $"../../GAME"


func _ready():
	game.connect("start", self, "gui_start")
	game.connect("game", self, "gui_game")
	game.connect("gameover", self, "gui_gameover")


func gui_start():
	gui.pause_mode = Node.PAUSE_MODE_STOP
	gui.visible = false
	game_over.pause_mode = Node.PAUSE_MODE_STOP
	game_over.visible = false
	start.pause_mode = Node.PAUSE_MODE_PROCESS
	start.visible = true


func gui_game():
	start.pause_mode = Node.PAUSE_MODE_STOP
	start.visible = false
	game_over.pause_mode = Node.PAUSE_MODE_STOP
	game_over.visible = false
	gui.pause_mode = Node.PAUSE_MODE_PROCESS
	gui.visible = true


func gui_gameover():
	gui.pause_mode = Node.PAUSE_MODE_STOP
	gui.visible = false
	game_over.pause_mode = Node.PAUSE_MODE_PROCESS
	game_over.visible = true
	points.text = "POINTS: " + String(game.points)
	best_record.text = "BEST RECORD\n" + String(game.best_record)
