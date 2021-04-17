extends KinematicBody2D

var active = false
var joypad_device_id
var id

onready var stats = $Stats

func activate():
    active = true
    
func deactivate():
    active = false

func hit():
    stats.lives -= 1
    if stats.lives <= 0:
        $AnimatedSprite.animation = "dead"
        deactivate()
