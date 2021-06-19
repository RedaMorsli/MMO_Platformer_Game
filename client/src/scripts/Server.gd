extends Node

var net : NetworkedMultiplayerENet

var ping_time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("server_disconnected", self, "_server_disconnected")

remote func updatePlayerPosition(id, pos):
	get_node("/root/Game/Level/Players/" + str(id)).position = pos

remote func set_player_info(id, player_info):
	print("Set player info for " + str(id))
	get_node("/root/Game/Level/Players/" + str(id)).display_name = player_info["name"]
	get_node("/root/Game/Level/Players/" + str(id)).color = player_info["color"]

func connect_to_server(ip, port):
	get_node("/root/Game/GUI/Menu/ColorRect/MarginContainer/VBoxContainer/BtnJoin").disabled = true
	print("Connecting to the server...")
	net = NetworkedMultiplayerENet.new()
	net.create_client(ip, int(port))
	get_tree().network_peer = net

func sendPosition(id, pos):
	rpc_unreliable("updatePlayerPosition", id, pos)

func _player_connected(id):
	if id == 1:
		return
	print("Player" + str(id) + " connected")
	get_node("/root/Game").spawnPlayer(id)
	# send player info
	var color = get_node("/root/Game/GUI/Menu/ColorRect/MarginContainer/VBoxContainer/HBoxContainer/CenterContainer/ColorPickerButton").color
	var display_name = get_node("/root/Game/GUI/Menu/ColorRect/MarginContainer/VBoxContainer/DisplayName").text
	var player_info = {"name" : display_name, "color" : color}
	rpc_id(id, "set_player_info", get_tree().get_network_unique_id(), player_info)


func _player_disconnected(id):
	print("Player" + str(id) + " disconnected")
	get_node("/root/Game").despawnPlayer(id)

func _connected_ok():
	print("Connected to the server successfully")
	get_node("/root/Game").spawnSelfPlayer()
	

func _server_disconnected():
	print("Disconnected from the server")
	get_node("/root/Game/GUI/Menu/ColorRect/MarginContainer/VBoxContainer/BtnJoin").disabled = false
	get_node("/root/Game").despawnSelfPlayer()

func _connected_fail():
	print("Client failed to connect")
	get_node("/root/Game/GUI/Menu/ColorRect/MarginContainer/VBoxContainer/BtnJoin").disabled = false

func ping():
	ping_time = OS.get_system_time_msecs()
	rpc_unreliable_id(1, "ping", get_tree().get_network_unique_id())

remote func pong():
	ping_time = OS.get_system_time_msecs() - ping_time
	get_node("/root/Game/GUI/Ping").updatePing(ping_time)
