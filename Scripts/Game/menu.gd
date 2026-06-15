extends Node2D

var level_selector = preload("res://Scenes/UI/level_selector.tscn")
@onready var server = $ServerManager
@onready var room = $Room
@onready var interface = $Room/Interface
@onready var menu = $Room/Interface/main_menu

func _ready() -> void:
	Global.create_pressed.connect(on_create_pressed)
	Global.join_pressed.connect(on_join_pressed)
	Global.level_selector_openned.connect(show_level_selector)
	Global.level1_selected.connect(level_builder)

func on_join_pressed(address) -> void:
	var ip_to_connect = address
	if ip_to_connect== "":
		ip_to_connect = "127.0.0.1"
	server.CreateClient(ip_to_connect)
	menu.queue_free()

func on_create_pressed() -> void:
	server.CreateServer()
	menu.queue_free()
	
func show_level_selector() -> void:
	var level_ui =level_selector.instantiate()
	interface.add_child(level_ui)

func level_builder() -> void:
	if room.has_node("Lobby"):
		print("Ingresa")
		$Room/Interface/LevelSelector.queue_free()
		$Room/Lobby.queue_free()
	var level1 = preload("res://Scenes/Game/level_1.tscn")
	var level = level1.instantiate()
	room.add_child(level)
	room.move_child(level,0)
