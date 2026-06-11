extends CharacterBody2D

const SPEED = 300.0
var FacingRight = true
var current_animation: AnimatedSprite2D
@onready var animator = $AnimatedSprite2D

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())
	
func _ready() -> void:
	if !is_multiplayer_authority():
		return
	current_animation = animator
	
func _physics_process(delta: float) -> void:
	if !is_multiplayer_authority():
		return
	var direction = Input.get_vector("left","right","up","down")
	velocity = SPEED * direction
	update_animation()
	flip()
	move_and_slide()

func flip():
	if(FacingRight and velocity.x<0) or (not FacingRight and velocity.x > 0):
		animator.flip_h = FacingRight
		FacingRight = not FacingRight


func update_animation():
	if velocity.x or velocity.y:
		animator.play("walk")
	else:
		animator.play("Idle")

func set_spawn():
	global_position.x = 300
	global_position.y = 300
