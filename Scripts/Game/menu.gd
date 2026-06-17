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
	Global.loading_finished.connect(prepare_level)
	Global.level_finished.connect(show_results)
	Global.back_to_lobby.connect(go_to_lobby)

func on_join_pressed(address) -> void:
	var ip_to_connect = address
	if ip_to_connect== "":
		ip_to_connect = "127.0.0.1"
	server.CreateClient(ip_to_connect)
	menu.queue_free()
	Global.play_menu_music.emit()

func on_create_pressed() -> void:
	server.CreateServer()
	menu.queue_free()
	Global.play_menu_music.emit()
	
func show_level_selector() -> void:
	var level_ui =level_selector.instantiate()
	interface.add_child(level_ui)

func level_builder() -> void:
	if room.has_node("Lobby"):
		$Room/Interface/LevelSelector.queue_free()
		$Room/Lobby.queue_free()
	var loadingUI = preload("res://Scenes/UI/loading.tscn")
	var level1 = preload("res://Scenes/Game/level_1.tscn")
	var level = level1.instantiate()
	var load = loadingUI.instantiate()
	interface.add_child(load)
	room.add_child(level)
	room.move_child(level,0)

func prepare_level():
	var beat_ui = preload("res://Scenes/UI/beat_interface.tscn")
	var b_ui = beat_ui.instantiate()
	interface.add_child(b_ui)

func show_results():
	if interface.has_node("BeatInterface"):
		$Room/Interface/BeatInterface.queue_free()
	var results = preload("res://Scenes/UI/results.tscn")
	var res = results.instantiate()
	interface.add_child(res)


func go_to_lobby():
	Global.is_on_lobby= true
	if room.has_node("Level1"):
		$Room/Level1.queue_free()
	var lob = preload("res://Scenes/Game/lobby.tscn")
	var loby = lob.instantiate()
	room.add_child(loby)
	room.move_child(loby,0)
	Global.play_menu_music.emit()
