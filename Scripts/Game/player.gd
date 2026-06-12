extends CharacterBody2D

const SPEED = 300.0
var FacingRight = true
@onready var animator = $AnimatedSprite2D
@onready var camera = $Camera2D

func _enter_tree() -> void:
	# Convertimos el nombre a entero para establecer la autoridad
	set_multiplayer_authority(name.to_int())
	
func _ready() -> void:
	# El que tiene la autoridad es el que controla al personaje,
	# por lo tanto, es el único que debe tener la cámara activa.
	if is_multiplayer_authority():
		camera.enabled = true
		camera.make_current()
	else:
		camera.enabled = false
	
func _physics_process(delta: float) -> void:
	# Si no soy el dueño, no proceso nada de movimiento
	if !is_multiplayer_authority():
		return
		
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * SPEED
	
	update_animation()
	flip()
	move_and_slide()

func flip():
	if (FacingRight and velocity.x < 0) or (not FacingRight and velocity.x > 0):
		animator.flip_h = !FacingRight # Ajustado para consistencia
		FacingRight = !FacingRight

func update_animation():
	if velocity != Vector2.ZERO:
		animator.play("walk")
	else:
		animator.play("Idle")
