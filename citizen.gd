extends StaticBody2D

export (String) var message

func _ready():
	$text/Label.text = message
	$text.hide()

func _on_player_detector_body_entered(body):
	if body.is_in_group("player"):
		$text.show()


func _on_player_detector_body_exited(body):
	if body.is_in_group("player"):
		$text.hide()
