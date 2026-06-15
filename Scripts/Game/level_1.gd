extends Node2D

@onready var animator = $AnimatedSprite2D
@onready var time = $Timer
var hand = preload("res://Scenes/Game/grave_attack.tscn")
var state = 0
func _ready() -> void:
	Global.is_on_lobby = false
	Global.level_started.emit()
	Global.loading_finished.connect(start_level)

func _process(delta: float) -> void:
	if state == 1:
		animator.animation = "idle"
	if state == 2:
		animator.animation = "attack"
		state = 1
	await animator.animation_finished

func start_level():
	await get_tree().create_timer(3).timeout
	animator.play("spawn")
	state = 1
	time.start()

func _on_timer_timeout() -> void:
	state=2

func invoke():
	for i in range(10):
		var randx = int(randf()) % 8
		var randy = int(randf()) % 5
		var inv = hand.instantiate()
		inv.set_spawn_position(randx,randy)
		add_child(inv)
		move_child(inv, 1)
