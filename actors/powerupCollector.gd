extends Area2D

func _on_powerupCollector_body_entered(body):
    if body.is_in_group("powerup"):
        body.apply_powerup(get_parent().stats)
