extends KinematicBody2D

export (int) var SPEED
export (int) var attack

var velocity = Vector2()

export (PackedScene) var projectile

func _ready():
	pass

func _process(delta):
	
	velocity = Vector2()
	
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
	

func _input(event):
	if event.is_action_pressed("click"):
		add_child(projectile.instance())

