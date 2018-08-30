extends Area2D

export (int) var coin_num
export (PackedScene) var coin

func _on_chest_area_entered(area):
	if area.is_in_group("projectile"):
		"""
		for i in range(coin_num):
			var new_coin = coin.instance()
			new_coin.position = position
			get_parent().add_child(new_coin)
		queue_free()
		"""
		var coin_creater = Thread.new()
		coin_creater.start(self, "create_coins_and_die", coin_num)

func create_coins_and_die(num):
	hide()
	for i in range(num):
		var new_coin = coin.instance()
		new_coin.position = position
		get_parent().add_child(new_coin)
	queue_free()
