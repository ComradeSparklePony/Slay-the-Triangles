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
	
	# update shop labels
	$text/speed.text = "Current Speed: " + str($player.SPEED)
	$text/coins.text = "Your coins: " + str($player.coins)
	$text/maxhp.text = "Current Max Hp: " + str($player.max_hp)
	$text/attack.text = "Current Attack: " + str($player.attack)
	$text/attackspeed.text = "Current Attack Speed: " + str($player.RELOAD_TIME)


func _on_hp_platform_body_entered(body):
	if body.is_in_group("player"):
		if body.coins >= 500:
			body.coins -= 500
			body.max_hp += 10
			body.hp += 10
			$text/coins.text = "Your coins: " + str(body.coins)
			$text/maxhp.text = "Current Max Hp: " + str(body.max_hp)


func _on_attack_platform_body_entered(body):
	if body.is_in_group("player"):
		if body.coins >= 500:
			body.coins -= 500
			body.attack += 10
			$text/coins.text = "Your coins: " + str(body.coins)
			$text/attack.text = "Current Attack: " + str(body.attack)


func _on_attack_spd_platform_body_entered(body):
	if body.is_in_group("player"):
		if body.coins >= 500:
			body.coins -= 500
			body.RELOAD_TIME = body.RELOAD_TIME/ 1.5
			$text/coins.text = "Your coins: " + str(body.coins)
			$text/attackspeed.text = "Current Attack Speed: " + str(body.RELOAD_TIME)


func _on_speed_platform_body_entered(body):
		if body.is_in_group("player"):
			if body.coins > 500:
				body.coins -= 500
				body.SPEED += 10
				$text/coins.text = "Your coins: " + str(body.coins)
				$text/speed.text = "Current Speed: " + str(body.SPEED)
