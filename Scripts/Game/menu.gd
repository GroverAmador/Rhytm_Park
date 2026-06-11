extends Node2D
@onready var IpText
@onready var addres = $CanvasLayer/BoxContainer/VBoxContainer/LineEdit.text
@onready var server=$ServerManager

func _ready() -> void:
	var ip = get_addres()
	$CanvasLayer/BoxContainer/VBoxContainer/IpLabel.text = "Your ip: " + ip
	$Ip.show()

	


func _on_join_pressed() -> void:
	server.CreateClient(addres)
	$CanvasLayer.hide()
	


func _on_create_pressed() -> void:
	var ip = get_addres()
	server.CreateServer()
	$CanvasLayer/BoxContainer/VBoxContainer/IpLabel.text = ip
	$CanvasLayer.hide()
	
func get_addres():
	var addresses = IP.get_local_addresses()
	for ip  in addresses:
		if(ip.begins_with("192")):
			return ip
