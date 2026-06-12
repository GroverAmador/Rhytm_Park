extends Sprite2D

var texture1 = preload("res://Resources/Sprites/UI/BeatInterface/sliding_notes1.png")
var texture2 = preload("res://Resources/Sprites/UI/BeatInterface/sliding_notes2.png")
var texture3 = preload("res://Resources/Sprites/UI/BeatInterface/sliding_notes3.png")
var speed
var btnx = 0
var btny = 0

@onready var textures = [texture1, texture2, texture3]

func _physics_process(delta: float) -> void:
	
	if global_position.x>0:
		global_position.x -= speed
	else:
		if global_position.x<0:
			queue_free()

func _ready() -> void:
	var txtr= int(randf()*100) % 3
	texture = textures[txtr]

func initialize(spawnx, spawny,targetx, targety):
	speed = (spawnx-targetx)/80.0
	position = Vector2(spawnx, spawny)
	btnx = targetx
	btny = targety
