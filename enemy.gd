extends KinematicBody2D

# vars
export (int) var SPEED
export (int) var ATTACK

var player
var velocity
var timer_active = false
export (int) var hp
export (PackedScene) var enemy_weapon
export (PackedScene) var coin

func _ready():
	# basic variable setup
	if get_parent().has_node("player"):
		player = get_parent().get_node("player")
	else:
		player = get_parent().get_parent().get_node("player")
	$TextureProgress.max_value = hp
	$TextureProgress.value = hp
	$Timer.wait_time = rand_range(2, 10)
	# create enemy weapon
	add_child(enemy_weapon.instance())

func _process(delta):
	# find player position and move towards it
	velocity = player.position - position
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
	
	# move
	move_and_collide(Vector2(velocity.x, 0) * delta)
	move_and_collide(Vector2(0, velocity.y) * delta)
	
	# start the timer if the enemy weapon was destroyed
	if not has_node("enemy-weapon") and (not timer_active):
		$Timer.start()
		timer_active = true

# take damage
func _on_Area2D_area_entered(area):
	if area.is_in_group("projectile"):
		hp = max(hp-player.attack,0)
		$TextureProgress.value = hp
		if hp == 0:
			var coin_amt = int(sqrt(ATTACK * SPEED))
			var coin_creater = Thread.new()
			coin_creater.start(self, "create_coins_and_die", coin_amt)

# create new weapon when neccecary
func _on_Timer_timeout():
	$Timer.wait_time = rand_range(2, 10)
	add_child(enemy_weapon.instance())
	timer_active = false

func create_coins_and_die(num):
	hide()
	for i in range(num):
		var new_coin = coin.instance()
		new_coin.position = position
		get_parent().add_child(new_coin)
	queue_free()
