extends Control


func _on_level_1_pressed() -> void:
	Global.level1_selected.emit()
