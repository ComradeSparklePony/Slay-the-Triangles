extends Node2D

# packed scenes
export (PackedScene) var food
export (PackedScene) var enemy
export (PackedScene) var chest
export (PackedScene) var wall

# metavars
export (int) var MAZESIZE
export (int) var FOOD_NUM
export (int) var CHEST_NUM

var wall_array #shows where walls are

func _ready():
	var maze_point = Vector2() # current position in maze
	var direction = Vector2() #where currently looking
	
	var directions = [Vector2(0,1), Vector2(0,-1), Vector2(1,0), Vector2(-1, 0)] #for generating purposes
	
	#Create empty maze
	wall_array = []
	for i in range(MAZESIZE):
		wall_array.append([])
	
	for y in range(MAZESIZE):
		for x in range(MAZESIZE):
			wall_array[y].append(0)
	
	
	### GENERATE MAZE (algorithm: choose a random point, then move 2 blocks and try directions until one works, repeat.
	direction = [directions][randi() % 4] #pick a random direction
	
	#fill the maze with 
	for tries in range(pow(MAZESIZE, 2)):
		maze_point = Vector2(randi() % MAZESIZE, randi() % MAZESIZE) #pick a random point in maze
		
		# figure out usable directions
		var use_directions = shuffle(directions)
		use_directions.remove(use_directions.find(direction))
		
		var failed = true
		for try_dir in use_directions:
			
			if wall_array[maze_point.x + (try_dir.x * 2)][maze_point.y + (try_dir.y * 2)] == 0 and failed:
				wall_array[maze_point.x + (try_dir.x)][maze_point.y + (try_dir.y)] = 1
				wall_array[maze_point.x + (try_dir.x * 2)][maze_point.y + (try_dir.y * 2)] = 1
				maze_point += try_dir * 2
				failed = false
				
			failed = true
	
	for i in wall_array:
		print(i)
		

func shuffle(array):
	var shuffle_array = []
	while array.size() > 0:
		var item = array[randi() % (array.size())]
		shuffle_array.append(item)
		array.erase(item)
	return shuffle_array