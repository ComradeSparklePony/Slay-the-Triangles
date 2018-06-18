extends KinematicBody2D

export (int) var SPEED

var player
var velocity
var timer_active = false
export (int) var hp
export (PackedScene) var enemy_weapon

func _ready():
	player = get_parent().get_node("player")
	$TextureProgress.max_value = hp
	$TextureProgress.value = hp
	$Timer.wait_time = rand_range(2, 10)
	add_child(enemy_weapon.instance())

func _process(delta):
	velocity = player.position - position
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
	
	move_and_collide(Vector2(velocity.x, 0) * delta)
	move_and_collide(Vector2(0, velocity.y) * delta)
	if not has_node("enemy-weapon") and (not timer_active):
		print("timer started")
		$Timer.start()
		timer_active = true

func _on_Area2D_area_entered(area):
	if area.is_in_group("projectile"):
		hp -= player.attack
		$TextureProgress.value = hp
		if hp == 0:
			queue_free()


func _on_Timer_timeout():
	print("timer finished")
	$Timer.wait_time = rand_range(2, 10)
	add_child(enemy_weapon.instance())
	timer_active = false
	
