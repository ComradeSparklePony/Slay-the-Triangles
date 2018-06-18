extends KinematicBody2D

export (int) var SPEED
export (int) var attack
export (float) var RELOAD_TIME

var velocity = Vector2()

export (PackedScene) var projectile

func _ready():
	$Timer.wait_time = RELOAD_TIME
	$Timer.start()

func _process(delta):
	
	# create projectile
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and RELOAD_TIME == 0:
		add_child(projectile.instance())
		$Timer.start()
	
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
	


