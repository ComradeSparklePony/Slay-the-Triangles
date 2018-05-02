extends KinematicBody2D

export (int) var SPEED

var player
var velocity
export (int) var hp

func _ready():
	player = get_parent().get_node("player")
	$TextureProgress.max_value = hp
	$TextureProgress.value = hp

func _process(delta):
	velocity = player.position - position
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
	
	move_and_collide(Vector2(velocity.x, 0) * delta)
	move_and_collide(Vector2(0, velocity.y) * delta)

func _on_Area2D_area_entered(area):
	if area.is_in_group("projectile"):
		hp -= player.attack
		$TextureProgress.value = hp
		if hp == 0:
			queue_free()
