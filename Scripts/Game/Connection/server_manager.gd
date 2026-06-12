extends Node
class_name ServerManager

@export var Player : PackedScene
@export var main_scene : Node 
@export var port : int = 8910 

var peer = ENetMultiplayerPeer.new()

func _ready():
	multiplayer.peer_connected.connect(_on_peer_connected)
	print("ServerManager listo.")

func CreateServer():
	var error = peer.create_server(port, 3)
	if error != OK:
		print("Error al crear servidor: ", error)
		return
	multiplayer.multiplayer_peer = peer
	print("Servidor iniciado en puerto: ", port)
	
	# Instanciar al jugador del servidor (ID 1)
	var player = Player.instantiate()
	player.name = "1"
	main_scene.add_child(player, true)

func CreateClient(address: String):
	var error = peer.create_client(address, port)
	if error != OK:
		print("Error al conectar: ", error)
		return
	multiplayer.multiplayer_peer = peer
	print("Intentando conectar a: ", address)

func _on_peer_connected(id):
	print("Jugador unido con ID: ", id)
	if multiplayer.is_server():
		var player = Player.instantiate()
		player.name = str(id)
		main_scene.add_child(player, true)
