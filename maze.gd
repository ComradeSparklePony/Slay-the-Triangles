extends Node2D

export (PackedScene) var wall
export (int) var MAZESIZE
export (int) var TUNNELS

var wall_array

func _ready():
	randomize()
	
	var directions = [Vector2(1,0), Vector2(0,1),Vector2(-1,0), Vector2(0,-1)]
	var maze_point = []
	
	wall_array = []
	for i in range(MAZESIZE):
		wall_array.append([])
	
	for y in range(MAZESIZE):
		for x in range(MAZESIZE):
			wall_array[y].append(0)
	print(wall_array)
	
	maze_point = Vector2((randi() % MAZESIZE), (randi() % MAZESIZE))
	
	while TUNNELS > 0:
		direction = directions[randi() % 4]
		length = randi() % MAZESIZE

