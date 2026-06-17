extends Node2D
const cell_size = 50
const grid_size_x = 10
const grid_size_y = 6

func _ready() -> void:
	queue_redraw()
func _draw() -> void:
	draw_grid()

func draw_grid():
	var color = Color("white")
	for x in range(grid_size_x + 1):
		var x_pos = 150 + x * cell_size
		draw_line(Vector2(x_pos, 95),Vector2(x_pos,395),color,2)
	for y in (grid_size_y + 1):
		var y_pos = 95 + y * cell_size
		draw_line(Vector2(150, y_pos), Vector2(650,y_pos), color, 2)
