extends Control


func _on_level_1_pressed() -> void:
	Global.level1_selected.emit()


func _on_close_pressed() -> void:
	queue_free()
