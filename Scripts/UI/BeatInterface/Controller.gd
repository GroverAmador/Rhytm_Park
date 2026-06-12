extends CanvasLayer

var instance
var note = load("res://Scenes/UI/note.tscn")
var hit = false
var normal_button=preload("res://Resources/Sprites/UI/BeatInterface/Note1.png")
var pressed_button=preload("res://Resources/Sprites/UI/BeatInterface/Note2.png")
@onready var spawn = $Spawn
@onready var button = $Sprite2D


func _ready() -> void:
	await get_tree().create_timer(1).timeout
	$AudioStreamPlayer.play()



func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("up")):
		if hit:
			print("Accion capturada")
		else:
			print("Accion no capturada")
		button.texture=pressed_button
		await get_tree().create_timer(0.1).timeout
		button.texture= normal_button
		



func _on_area_2d_area_entered(area: Area2D) -> void:
	hit = true;
	
	


func _on_audio_stream_player_beat() -> void:
	instance = note.instantiate()
	instance.initialize(spawn.global_position.x, spawn.global_position.y, button.global_position.x, button.global_position.y)
	add_child(instance)
	move_child(instance, 1)


func _on_area_2d_area_exited(area: Area2D) -> void:
	hit = false
