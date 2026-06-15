extends CharacterBody2D

const SPEED = 250.0
var FacingRight = true
var is_on_lobby
@onready var animator = $AnimatedSprite2D

func _enter_tree() -> void:
	# Convertimos el nombre a entero para establecer la autoridad
	set_multiplayer_authority(name.to_int())
	
func _ready() -> void:
	Global.level_started.connect(set_level_start_position)
	global_position = Vector2(480,248)
	if is_multiplayer_authority():
		return
	
func _physics_process(delta: float) -> void:
	is_on_lobby = Global.is_on_lobby
	if is_multiplayer_authority():
		movement()
		flip()
		move_and_slide()
	animator.play()

func movement():
	if is_on_lobby:
		var direction = Input.get_vector("left", "right", "up", "down")
		velocity = direction * SPEED
		update_animation()
	else:
		var directionx = Input.get_axis("left","right")
		var directiony = Input.get_axis("up","down")
		if(global_position.x<600) and (global_position.x>200):
			global_position.x += 50 * directionx
		if(global_position.y>120) and (global_position.y<370):
			global_position.y += 50 * directiony
		dance()

func dance():
	var dances = ["dance_move1","dance_move2","dance_move3"]
	var rand = int(randf()) % 3
	animator.animation = dances[rand]


func flip():
	if (FacingRight and velocity.x < 0) or (not FacingRight and velocity.x > 0):
		animator.flip_h = FacingRight 
		FacingRight = !FacingRight


func update_animation():
	if velocity != Vector2.ZERO:
		animator.animation = "walk"
	else:
		animator.animation = "Idle"

func set_level_start_position():
	global_position = Vector2(200,220)
