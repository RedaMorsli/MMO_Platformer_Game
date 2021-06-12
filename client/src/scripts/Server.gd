extends Node

var net : NetworkedMultiplayerENet

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("server_disconnected", self, "_server_disconnected")

remote func updatePlayerPosition(id, pos):
	get_node("/root/Game/Level/Players/" + str(id)).position = pos

func connect_to_server(ip, port):
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

func _player_disconnected(id):
	print("Player" + str(id) + " disconnected")

func _connected_ok():
	print("Connected to the server successfully")
	get_node("/root/Game").spawnSelfPlayer()

func _server_disconnected():
	print("Disconnected from the server")
	get_node("/root/Game").despawnSelfPlayer()

func _connected_fail():
	print("Client failed to connect")
