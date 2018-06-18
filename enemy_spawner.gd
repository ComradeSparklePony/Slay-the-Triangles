extends KinematicBody2D

export (PackedScene) var enemy

export (int) var ROT_SPEED
export (int) var SPEED
var velocity
var player

var first_process = true

export (int) var max_hp
var hp

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
	
	$Timer.wait_time = 1
	$Timer.start()
	

func _process(delta):
	
	#rotate triangles
	$tri1.rotate(ROT_SPEED * delta)
	$tri2.rotate(ROT_SPEED * delta * -1)
	
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
	var player_distance
	player_distance = position.distance_to(player.position)
	$Timer.wait_time = player_distance / 30
	var new_enemy = enemy.instance()
	new_enemy.position = position
	get_parent().add_child(new_enemy)
	$Timer.start()
