extends Node2D

# Referencias a los nodos necesarios
@onready var line_edit = $CanvasLayer/BoxContainer/VBoxContainer/LineEdit
@onready var ip_label = $CanvasLayer/BoxContainer/VBoxContainer/IpLabel
@onready var server = $ServerManager

func _ready() -> void:
	var ip = get_address()
	ip_label.text = "Tu IP: " + ip
	# $Ip.show() # Asegúrate de que este nodo exista, si no, coméntalo

func _on_join_pressed() -> void:
	# AQUÍ ESTÁ LA CORRECCIÓN: Leemos el texto en el momento exacto del clic
	var ip_a_conectar = line_edit.text.strip_edges()
	
	if ip_a_conectar == "":
		print("Campo de IP vacío, intentando con 127.0.0.1")
		ip_a_conectar = "127.0.0.1"
	
	print("Conectando a: ", ip_a_conectar)
	server.CreateClient(ip_a_conectar)
	$CanvasLayer.hide()

func _on_create_pressed() -> void:
	# server.CreateServer() usará el puerto definido en el ServerManager
	server.CreateServer()
	$CanvasLayer.hide()
	
func get_address():
	var addresses = IP.get_local_addresses()
	for ip in addresses:
		if ip.begins_with("192.168."):
			return ip
	return "127.0.0.1"
