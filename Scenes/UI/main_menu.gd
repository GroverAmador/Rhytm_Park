extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_buttons.visible = true
	panel_settings.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_host_pressed():
	pass # Replace with function body.

func _on_join_2_pressed():
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()

@onready var main_buttons: VBoxContainer = $MainButtons
@onready var panel_settings: Panel = $panel_settings

func _on_settings_pressed() -> void:
	main_buttons.visible = false
	panel_settings.visible = true


func _on_back_pressed() -> void:
	_ready()
