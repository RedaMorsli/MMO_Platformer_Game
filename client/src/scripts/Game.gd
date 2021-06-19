extends Node

var player = preload("res://src/scenes/Player.tscn")
var player_other = preload("res://src/scenes/PlayerTemplate.tscn")

onready var editNetInfo = $GUI/Menu/ColorRect/MarginContainer/VBoxContainer/EditNetInfo
onready var colorPick = $GUI/Menu/ColorRect/MarginContainer/VBoxContainer/HBoxContainer/CenterContainer/ColorPickerButton
onready var editName = $GUI/Menu/ColorRect/MarginContainer/VBoxContainer/DisplayName

func _on_BtnJoin_pressed():
	var ip_port = editNetInfo.text.split(":")
	if ip_port.size() != 2:
		return
	Server.connect_to_server(ip_port[0], ip_port[1])
	

func spawnSelfPlayer():
	$GUI/Menu.visible = false
	var new_player = player.instance()
	new_player.display_name = editName.text
	new_player.color = colorPick.color
	new_player.position = $Level.getSpawnPosition()
	new_player.name = str(get_tree().get_network_unique_id())
	new_player.set_network_master(get_tree().get_network_unique_id())
	new_player.set_camera(true)
	new_player.connect("respawn", $Level,"_on_Player_respawn")
	$Level/Players.add_child(new_player)
	$GUI/Ping.start()

func spawnPlayer(id):
	if get_tree().get_network_unique_id() == id or id == 1:
		return
	var new_player = player_other.instance()
	new_player.position = $Level.getSpawnPosition()
	new_player.name = str(id)
	new_player.set_network_master(id)
	$Level/Players.add_child(new_player)

func despawnPlayer(id):
	get_node("/root/Game/Level/Players/" + str(id)).queue_free()

func despawnSelfPlayer():
	for player in get_node("/root/Game/Level/Players").get_children():
		player.queue_free()
	$GUI/Menu.visible = true
	$GUI/Ping.stop()

