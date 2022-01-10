extends Control

signal mouse_click


func _ready():
	connect("gui_input", self, "get_input")


func get_input(event):
	if event is InputEventMouseButton and event.pressed:
		emit_signal("mouse_click")
