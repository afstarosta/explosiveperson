extends Area2D

onready var parent = get_parent()

func _on_PowerUpCollector_body_entered(body:Object):
	if body.is_in_group("powerup"):
		body.apply_powerup(parent.stats)
