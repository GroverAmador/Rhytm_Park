extends CharacterBody2D

const SPEED = 250.0
var FacingRight = true
var is_on_lobby = true
@onready var animator = $AnimatedSprite2D
var is_moving = false
var direction_on_level = Vector2.ZERO
func _input(event: InputEvent) -> void:
	if is_multiplayer_authority():
		if is_moving:
			return
		if !is_on_lobby:
			if event is InputEventKey and event.is_pressed() and !is_moving and Global.hit_note:
				if event.keycode == KEY_W && global_position.y > 120.2:
					direction_on_level = Vector2.UP
				if event.keycode == KEY_S and global_position.y < 370:
					direction_on_level = Vector2.DOWN
				if event.keycode == KEY_A and global_position.x > 200:
					direction_on_level = Vector2.LEFT
				if event.keycode == KEY_D and global_position.x < 600:
					direction_on_level = Vector2.RIGHT
				if direction_on_level != Vector2.ZERO:
					move_on_grid()
					

func _enter_tree() -> void:
	# Convertimos el nombre a entero para establecer la autoridad
	set_multiplayer_authority(name.to_int())
	
func _ready() -> void:
	Global.level_started.connect(set_level_start_position)
	Global.back_to_lobby.connect(set_lobby_position)
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
		
func move_on_grid():
	is_moving = true
	var tween = create_tween()
	dance()
	tween.tween_property(self, "global_position", global_position + 50 * direction_on_level, 0.2)
	tween.tween_callback(move_finished)

func dance():
	var dances = ["dance_move1","dance_move2","dance_move3"]
	var rand = randi_range(0,2)
	animator.animation = dances[rand]
	animator.play()

func move_finished():
	is_moving = false
	direction_on_level = Vector2.ZERO

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
	global_position = Vector2(220.1, 220.1)

func set_lobby_position():
	global_position = Vector2(480,248)
