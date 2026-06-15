extends Control
@onready var ip = $MainButtons/IpSpace


func _ready() -> void:
	main_buttons.visible = true
	panel_settings.visible = false


func _on_host_pressed():
	Global.create_pressed.emit()

func _on_join_2_pressed():
	Global.join_pressed.emit(ip.text)


func _on_exit_pressed() -> void:
	get_tree().quit()

@onready var main_buttons: VBoxContainer = $MainButtons
@onready var panel_settings: Panel = $panel_settings

func _on_settings_pressed() -> void:
	main_buttons.visible = false
	panel_settings.visible = true


func _on_back_pressed() -> void:
	_ready()
