extends KinematicBody2D

var active = false
var joypad_device_id
var id

func activate():
    active = true
    
func deactivate():
    active = false

func hit():
    $AnimatedSprite.animation = "dead"
    deactivate()
