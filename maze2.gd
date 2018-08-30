extends Node2D

# packedscenes and metavars
export (int) var MAZESIZE
export (int) var TUNLEN
export (int) var TUNNELS
export (int) var FOOD_NUM
export (int) var CHEST_NUM
export (PackedScene) var food
export (PackedScene) var enemy
export (PackedScene) var chest
export (PackedScene) var wall

# wall array contaisn where the walls are
var wall_array
var tunnels

func _ready():
	
	tunnels = TUNNELS
	randomize()
	
	# directions
	var vert_directions = [Vector2(0,1), Vector2(0,-1)]
	var hori_directions = [Vector2(1,0), Vector2(-1, 0)]
	# place in the maze and direction
	var maze_point = Vector2()
	var direction = Vector2()
	var length
	
	#Create empty maze
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
		
		length = rand_range(5, TUNLEN)
		
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

	
	for y in wall_array:
		for x in y:
			if x == 0:
				var new_wall = wall.instance()
				new_wall.position = maze_point
				add_child(new_wall)
			maze_point.x += 100
				
		maze_point.y += 100
		maze_point.x = 0
	
	var foods_created = 0
	while foods_created < FOOD_NUM:
		var x = randi() % MAZESIZE
		var y = randi() % MAZESIZE
		if wall_array[y][x] ==1:
			var new_food = food.instance()
			new_food.position = Vector2(x, y) * 100
			add_child(new_food)
			foods_created += 1
	
	var chests_created = 0
	while chests_created < CHEST_NUM:
		var x = randi() % MAZESIZE
		var y = randi() % MAZESIZE
		if wall_array[y][x] ==1:
			var new_chest = chest.instance()
			new_chest.position = Vector2(x, y) * 100
			add_child(new_chest)
			chests_created += 1
	
	#spawn player at an open area
	var player_spawned = false
	for y in shuffle(range(MAZESIZE)):
		for x in shuffle(range(MAZESIZE)):
			if wall_array[y][x] == 1 and not player_spawned:
				$player.position = Vector2(x, y) * 100
				player_spawned = true
				
	#spawn spawner at open area randomly
	var spawner_spawned = false
	for y in shuffle(range(MAZESIZE)):
		for x in shuffle(range(MAZESIZE)):
			if wall_array[y][x] == 1 and not spawner_spawned:
				$"enemy-spawner".position = Vector2(x, y) * 100
				spawner_spawned = true
	
				

# shuffles arrays
func shuffle(array):
	var shuffle_array = []
	while array.size() > 0:
		var item = array[randi() % (array.size())]
		shuffle_array.append(item)
		array.erase(item)
	return shuffle_array
	
	

# randomly place a new enemy just for excitement
func _on_Timer_timeout():
	var new_enemy = enemy.instance()
	var enemy_spawned = false
	for y in shuffle(range(MAZESIZE)):
		for x in shuffle(range(MAZESIZE)):
			if wall_array[y][x] == 1 and not enemy_spawned:
				new_enemy.position = Vector2(x, y) * 100
				enemy_spawned = true
	add_child(new_enemy)
