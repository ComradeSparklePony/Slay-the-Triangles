extends Node2D

var completion

func _ready():
	#load the game
	var save_file = File.new()
	save_file.open("user://data.save", File.READ)
	var data = parse_json(save_file.get_line())
	
	completion = data["completion"]
	save_file.close()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
