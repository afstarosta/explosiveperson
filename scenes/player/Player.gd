extends Node2D

var active = false
var joypad_device_id

func activate():
    active = true
    
func deactivate():
    active = false
