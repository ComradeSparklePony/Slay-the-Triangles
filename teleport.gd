extends Area2D

export (int) var ROT_SPEED
export (String, FILE) var SCENE_TO

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	rotate(ROT_SPEED * PI * delta)


func _on_teleport_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene(SCENE_TO)
