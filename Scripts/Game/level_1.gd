extends Node2D
@onready var animator = $AnimatedSprite2D
@onready var time = $Timer
var hand = preload("res://Scenes/Game/grave_attack.tscn")
func _ready() -> void:
	Global.is_on_lobby = false
	Global.level_started.emit()
	Global.loading_finished.connect(start_level)
	Global.level_finished.connect(finish_level)

func _process(delta: float) -> void:
	await animator.animation_finished
	animator.animation = "idle"
	animator.play()

func start_level():
	await get_tree().create_timer(0.2).timeout
	animator.play("spawn")
	time.start()

func _on_timer_timeout() -> void:
	animator.animation = "attack"
	await animator.animation_finished
	invoke()

func invoke():
	for i in range(25):
		var inv = hand.instantiate()
		var randx = randi_range(0,(620 - 170)/50)
		var pos_x = 170 + (randx * 50)
		var randy = randi_range(0,(370-120)/50)
		var pos_y = 120 + (randy * 50)
		inv.position = Vector2(pos_x,pos_y)
		add_child(inv)
		move_child(inv, 1)

func finish_level():
	time.stop()
	get_tree().paused
