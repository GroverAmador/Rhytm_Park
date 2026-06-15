extends Node2D

@onready var animation = $AnimatedSprite2D
var makes_damage = false
var body_is_in = false
func _ready() -> void:
	animation.play("spawn")
	await animation.animation_finished
	animation.play("waiting")
	await get_tree().create_timer(4).timeout
	makes_damage = true
	animation.play("attack")
	await animation.animation_finished
	makes_damage = false
	queue_free()

func _process(delta: float) -> void:
	if(body_is_in and makes_damage):
		Global.damage_received.emit()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body_is_in = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		body_is_in = false

func set_spawn_position(globalx, globaly):
	global_position.x = globalx
	global_position.y = globaly
