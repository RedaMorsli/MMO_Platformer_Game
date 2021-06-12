extends Control

onready var startButton = $MarginContainer/VBoxContainer/HBoxContainer/StartServer
onready var stopButton = $MarginContainer/VBoxContainer/HBoxContainer/StopServer
onready var textIP = $MarginContainer/VBoxContainer/TextTP

func _ready():
	pass


func _on_StartServer_pressed():
	textIP.text = Server.start_server()
	stopButton.disabled = false
	startButton.disabled = true


func _on_StopServer_pressed():
	Server.stop_server()
	stopButton.disabled = true
	startButton.disabled = false
	textIP.text = ""
