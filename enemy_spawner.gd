extends KinematicBody2D

export (PackedScene) var enemy

export (int) var ROT_SPEED
export (int) var SPEED
var velocity
var player

var first_process = true
var first_hit = true

export (int) var max_hp
var hp

export (PackedScene) var coin

var slow_mo = false

# rotate tri2 180 degrees and initialize velocity
func _ready():
	randomize()
	# rotate tri2 180 degrees and initialize velocity
	$tri2.rotate(2*3.1415926535)
	velocity = Vector2(0,0)
	
	hp = max_hp
	
	# init textureprogress
	$TextureProgress.max_value = max_hp
	$TextureProgress.value = hp
	
	# player
	player = get_parent().get_node("player")
	
	$Timer.wait_time = 5
	$Timer.start()
	

func _process(delta):
	
	#rotate triangles
	$tri1.rotate(ROT_SPEED * delta)
	$tri2.rotate(ROT_SPEED * delta * -1)
	
	if not slow_mo:
		# randomly adjust velocity
		velocity += Vector2(rand_range(-1,1),rand_range(-1,1))
		if velocity.x > 5:
			velocity.x = -3
		if velocity.x < -5:
			velocity.x = 3
		if velocity.y > 5:
			velocity.y = -3
		if velocity.y < -5:
			velocity.y = 3
		
		# move
		move_and_collide(Vector2(velocity.x,0) * SPEED)
		move_and_collide(Vector2(0,velocity.y) * SPEED)
	


# spawn enemies
func _on_Timer_timeout():
	if not slow_mo:
		var player_distance
		player_distance = position.distance_to(player.position)
		$Timer.wait_time = player_distance / 70
		var new_enemy = enemy.instance()
		new_enemy.position = position
		get_parent().add_child(new_enemy)
		$Timer.start()

# remove hp if in contact with player projectile
func _on_Area2D_area_entered(area):
	
	if area.is_in_group("projectile"):
		hp -= player.attack
		$TextureProgress.value = hp
		if hp == 0:
			slow_mo = true
			var coin_amt = SPEED * 100
			#Engine.time_scale = 0.3
			for i in range(int(coin_amt)):
				#$Timer.wait_time = 0.00000000001
				var new_coin = coin.instance()
				new_coin.position = position + Vector2(rand_range(-i, i), rand_range(-i, i))/5
				get_parent().add_child(new_coin)
				#$Timer.start()
				#yield($Timer,"timeout")
			#Engine.time_scale = 1
			queue_free()

		if first_hit:
			$Timer.wait_time = 0.1
			get_parent().add_child(enemy.instance())
			$Timer.start()
			first_hit = false

