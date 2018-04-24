extends Node2D

export (PackedScene) var wall
export (int) var MAZESIZE

var wall_array

func _ready():
	randomize()
	
	var directions = [[1,0],[0,1],[-1,0],[0,-1]]
	
	wall_array = []
	for i in range(MAZESIZE):
		wall_array.append([])
	
	for y in range(MAZESIZE):
		for x in range(MAZESIZE):
			wall_array[y].append(0)
	print(wall_array)
	
	"""
	for y in range(MAZESIZE):
		for x in range(MAZESIZE):
			if wall_array[:
				wall_array[y][x] = 0
	"""


