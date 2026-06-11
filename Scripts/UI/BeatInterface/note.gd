extends Sprite2D

var texture1 = preload("res://Resources/Sprites/UI/BeatInterface/sliding_notes1.png")
var texture2 = preload("res://Resources/Sprites/UI/BeatInterface/sliding_notes2.png")
var texture3 = preload("res://Resources/Sprites/UI/BeatInterface/sliding_notes3.png")
var speed
var btnx = 0
var btny = 0

@onready var textures = [texture1, texture2, texture3]

func _physics_process(delta: float) -> void:
	if position.x>=btnx:
		position.x += speed
	else:
		if position.x<btnx+200:
			queue_free()

func _ready() -> void:
	var txtr= int(randf()*100) % 3
	texture = textures[txtr]

func initialize(spawnx, spawny,targetx, targety):
	speed = targetx - spawnx/15.0
	position = Vector2(spawnx, spawny)
	btnx = targetx
	btny = targety
