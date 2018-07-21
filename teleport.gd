extends Area2D

export (int) var ROT_SPEED
export (String, FILE) var SCENE_TO

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	rotate(ROT_SPEED * PI * delta)


func _on_teleport_body_entered(body):
	if body.is_in_group("player"):
		var save_file = File.new()
		save_file.open("user://data.save", File.READ)
		var data = parse_json(save_file.get_line())
		save_file.close()
		var save_data = {
			"player_max_hp": body.max_hp,
			"player_hp": body.hp,
			"player_attack": body.attack,
			"attack_speed": body.RELOAD_TIME,
			"mvt_speed": body.SPEED,
			"coins": body.coins,
			"completion": data["completion"]
		}
		save_file.open("user://data.save", File.WRITE)
		save_file.store_line(to_json(save_data))
		save_file.close()
		get_tree().change_scene(SCENE_TO)
