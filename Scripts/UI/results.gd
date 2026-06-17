extends Control

@onready var state = $CanvasLayer/BoxContainer/Panel/VBoxContainer/Title
@onready var rnk = $CanvasLayer/BoxContainer/Panel/VBoxContainer/Points
func _ready() -> void:
	state.text = Global.state
	rnk.text = Global.rank
func _on_play_again_pressed() -> void:
	Global.level_started.emit()
	Global.loading_finished.emit()
	queue_free()


func _on_go_to_lobby_pressed() -> void:
	Global.back_to_lobby.emit()
	queue_free()
