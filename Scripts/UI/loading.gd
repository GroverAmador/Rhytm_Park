extends Control
@onready var animator =$BoxContainer/AnimatedSprite2D

func _ready() -> void:
	animator.play("default")
	await animator.animation_finished
	Global.loading_finished.emit()
	queue_free()
