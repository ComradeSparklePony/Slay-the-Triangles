extends Node2D

var completion

#upgrade vars
export (int) var hp_upgrade
export (int) var attack_upgrade
export (float) var attack_spd_upgrade
export (int) var speed

func _ready():
	#load the game
	var save_file = File.new()
	save_file.open("user://data.save", File.READ)
	var data = parse_json(save_file.get_line())
	
	completion = data["completion"]
	save_file.close()
