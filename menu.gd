extends Panel

export (int) var player_hp
export (int) var player_attack
export (float) var attack_speed
export (int) var mvt_speed

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass

# CREATE A NEW GAME
func _on_new_pressed():
	var save_data = {
		"player_max_hp": player_hp,
		"player_hp": player_hp - 20,
		"player_attack": player_attack,
		"attack_speed": attack_speed,
		"mvt_speed": mvt_speed,
		"coins": 0,
		"completion": 0,
	}
	var save_file = File.new()
	save_file.open("user://data.save", File.WRITE)
	save_file.store_line(to_json(save_data))
	save_file.close()
	get_tree().change_scene("res://tutorial.tscn")


func _on_load_pressed():
	get_tree().change_scene("res://town.tscn")


func _on_exit_pressed():
	get_tree().quit()
