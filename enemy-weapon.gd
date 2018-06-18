extends Area2D

export (int) var ROT_SPEED

# rotate
func _process(delta):
	rotate(0.01 * ROT_SPEED)
	
# destroy this if it gets hit by projectile
func _on_enemyweapon_area_entered(area):
	if area.is_in_group("projectile"):
		queue_free()
