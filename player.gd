extends KinematicBody2D

export (int) var SPEED
var velocity = Vector2()

var colliding = false

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
	
	
	move_and_collide(velocity * delta)
	

func _input(event):
	if event.is_action_pressed("click"):
		var active_projectile = projectile.instance()
		add_child(active_projectile)

