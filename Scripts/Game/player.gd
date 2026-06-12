extends CharacterBody2D

const SPEED = 250.0
var FacingRight = true
@onready var animator = $AnimatedSprite2D
@onready var camera = $Camera2D

func _enter_tree() -> void:
	# Convertimos el nombre a entero para establecer la autoridad
	set_multiplayer_authority(name.to_int())
	
func _ready() -> void:
	
	if is_multiplayer_authority():
		camera.enabled = true
		camera.make_current()
	else:
		camera.enabled = false
	
func _physics_process(delta: float) -> void:
	if is_multiplayer_authority():
		var direction = Input.get_vector("left", "right", "up", "down")
		velocity = direction * SPEED
		update_animation()
		flip()
		move_and_slide()
	animator.play()
func flip():
	if (FacingRight and velocity.x < 0) or (not FacingRight and velocity.x > 0):
		animator.flip_h = FacingRight # Ajustado para consistencia
		FacingRight = !FacingRight

func update_animation():
	if velocity != Vector2.ZERO:
		animator.animation = "walk"
	else:
		animator.animation = "Idle"
