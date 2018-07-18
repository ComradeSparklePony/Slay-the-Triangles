extends Node2D

var completion

func _ready():
	#load the game
	var save_file = File.new()
	save_file.open("user://data.save", File.READ)
	var data = parse_json(save_file.get_line())
	
	$player.max_hp = data["player_hp"]
	$player.hp = $player.max_hp
	$player.SPEED = data["mvt_speed"]
	$player.attack = data["player_attack"]
	$player.RELOAD_TIME = data["attack_speed"]
	
	$player.hp -= 20

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
