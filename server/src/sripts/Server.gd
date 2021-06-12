extends Node

const SERVER_PORT = 1909
const MAX_PLAYERS =  100
var server_ip = "127.0.0.1"
var net := NetworkedMultiplayerENet.new()
var players := []


func _ready():
	get_tree().connect("network_peer_connected", self, "_peer_connected")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	#get_tree().connect("connected_to_server", self, "_connected_ok")
	#get_tree().connect("connection_failed", self, "_connected_fail")
	#get_tree().connect("server_disconnected", self, "_server_disconnected")

func start_server() -> String:
	net.create_server(SERVER_PORT, MAX_PLAYERS)
	get_tree().network_peer = net
	print("Server started")
	return server_ip + ":" + str(SERVER_PORT)

func stop_server():
	get_tree().network_peer = null
	print("Server stopped")

remote func updatePlayerPosition(id, pos):
	pass

func _peer_connected(id):
	print("Player" + str(id) + " joined the game")

func _peer_disconnected(id):
	print("Player" + str(id) + " left the game")

func _connected_fail():
	print("Failed start server")
