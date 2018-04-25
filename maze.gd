extends Node2D

export (PackedScene) var wall
export (PackedScene) var player
export (int) var MAZESIZE
export (int) var TUNNELS

var wall_array
var tunnels

func _ready():
	tunnels = TUNNELS
	randomize()
	
	var vert_directions = [Vector2(0,1), Vector2(0,-1)]
	var hori_directions = [Vector2(1,0), Vector2(-1, 0)]
	var maze_point = Vector2()
	var direction = Vector2()
	var length
	
	#Create emptey maze
	wall_array = []
	for i in range(MAZESIZE):
		wall_array.append([])
	
	for y in range(MAZESIZE):
		for x in range(MAZESIZE):
			wall_array[y].append(0)
	
	
	#get random starting point and direction
	maze_point = Vector2((randi() % MAZESIZE), (randi() % MAZESIZE))
	
	direction = [vert_directions, hori_directions][randi() % 2][randi() % 2]
	
	while tunnels > 0:
		# get a random perpindicular direction
		if direction in vert_directions:
			direction = hori_directions[randi() % 2]
		else:
			direction = vert_directions[randi() % 2]
		
		length = (randi() % (MAZESIZE - 1)) + 1
		
		#repeat for length and as long as not colliding with wall
		while length > 0 and not (maze_point.x == 0 or maze_point.y == 0 or maze_point.x == MAZESIZE - 1 or maze_point.y == MAZESIZE - 1):
			wall_array[maze_point.y][maze_point.x] = 1
			maze_point += direction
			length -= 1
		if (maze_point.x == 0 or maze_point.y == 0 or maze_point.x == MAZESIZE - 1 or maze_point.y == MAZESIZE - 1):
			maze_point = Vector2((randi() % MAZESIZE), (randi() % MAZESIZE))
		tunnels -= 1
	
	# PLACE WALLS
	
	maze_point = Vector2(0,0)
	var new_wall
	
	for y in wall_array:
		for x in y:
			if x == 0:
				new_wall = wall.instance()
				new_wall.position = maze_point
				add_child(new_wall)
			maze_point.x += 100
		maze_point.y += 100
		maze_point.x = 0
	
	#spawn player at an open area
	var spawn_player
	var player_spawned = false
	for y in range(MAZESIZE):
		for x in range(MAZESIZE):
			if wall_array[y][x] == 1 and not player_spawned:
				spawn_player = player.instance()
				spawn_player.position = Vector2(x, y) * 100
				add_child(spawn_player)
				player_spawned = true
				
