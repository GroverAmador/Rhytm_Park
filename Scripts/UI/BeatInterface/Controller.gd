extends CanvasLayer

var instance
var note = load("res://Scenes/UI/note.tscn")
var normal_button=preload("res://Resources/Sprites/UI/BeatInterface/Note1.png")
var pressed_button=preload("res://Resources/Sprites/UI/BeatInterface/Note2.png")
@onready var spawn = $Spawn
@onready var button = $Sprite2D
@onready var life = $TextureProgressBar


func _ready() -> void:
	await get_tree().create_timer(2).timeout
	life.value = 10
	start_song()
	Global.damage_received.connect(update_health)



func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		button.texture=pressed_button
		await get_tree().create_timer(0.1).timeout
		button.texture= normal_button
		
		



func _on_area_2d_area_entered(area: Area2D) -> void:
	Global.hit_note = true;
	
	


func _on_audio_stream_player_beat() -> void:
	instance = note.instantiate()
	instance.initialize(spawn.global_position.x, spawn.global_position.y, button.global_position.x, button.global_position.y)
	add_child(instance)
	move_child(instance, 1)


func _on_area_2d_area_exited(area: Area2D) -> void:
	Global.hit_note = false

func start_song():
	$AudioStreamPlayer.play()

func update_health():
	if life.value > 1:
		life.value -= 1
	else:
		life.value -= 1
		var rank = get_rank()
		Global.state = "Game Over"
		Global.rank = rank
		Global.level_finished.emit()

func get_rank() -> String:
	var r: String
	match life.value:
		10.0:
			r="S"
		9.0:
			r="A+"
		8.0:
			r="A"
		7.0:
			r="B+"
		6.0:
			r="B"
		5.0:
			r="C+"
		4.0:
			r="C"
		3.0:
			r="D+"
		2.0:
			r= "D"
		1.0:
			r = "F"
		0.0:
			r = "Loser"
	return r


func _on_audio_stream_player_finished() -> void:
	var rank = get_rank()
	Global.state = "You Win!"
	Global.rank = "Your rank is" + rank
	Global.level_finished.emit()
	print(rank)
