extends KinematicBody2D

# vars
export (int) var SPEED
export (int) var attack
export (float) var RELOAD_TIME

export (int) var max_hp
var hp

var coins

var enemy_spawner

var velocity = Vector2()

export (PackedScene) var projectile

func _ready():
	# setup timer
	$Timer.wait_time = RELOAD_TIME
	$Timer.start()
	
	# prepare health bar
	hp = max_hp
	
	$TextureProgress.max_value = max_hp
	$TextureProgress.value = hp
	enemy_spawner = get_parent().get_node("enemy-spawner")
	
	coins = 0

func _process(delta):
	
	# create projectile
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and $Timer.time_left == 0:
		add_child(projectile.instance())
		$Timer.start()
		
	# point towards spawner
	if has_node("pointer"):
		if get_parent().has_node("enemy-spawner"):
			$pointer.look_at(enemy_spawner.position)
		else:
			$pointer.queue_free()
	
	velocity = Vector2()
	
	# move
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
	
	
	move_and_collide(Vector2(velocity.x, 0) * delta)
	move_and_collide(Vector2(0, velocity.y) * delta)
	

func _on_Area2D_area_entered(area):
	# remove attack from hp
	if area.is_in_group("enemy_weapon"):
		# gets the enemy's attack
		var enemy_ATTACK = area.get_parent().ATTACK
		hp -= enemy_ATTACK
		$TextureProgress.value = hp
		if hp == 0:
			queue_free()
