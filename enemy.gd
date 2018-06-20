extends KinematicBody2D

# vars
export (int) var SPEED
export (int) var ATTACK

var player
var velocity
var timer_active = false
export (int) var hp
export (PackedScene) var enemy_weapon

func _ready():
	# basic variable setup
	player = get_parent().get_node("player")
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
		hp -= player.attack
		$TextureProgress.value = hp
		if hp == 0:
			queue_free()

# create new weapon when neccecary
func _on_Timer_timeout():
	if has_node("enemy-spawner"):
		$Timer.wait_time = rand_range(2, 10)
		add_child(enemy_weapon.instance())
		timer_active = false
	
