extends Control
@onready var animator =$CanvasLayer/BoxContainer/VBoxContainer/AnimatedSprite2D
@onready var bear = $CanvasLayer/AnimatedSprite2D
@onready var move = $CanvasLayer/AnimationPlayer

func _ready() -> void:
	animator.play("default")
	bear.play("default")
	move.play("bear")
	await animator.animation_finished
	Global.loading_finished.emit()
	queue_free()
