extends Node2D

func _input(event):
    if event is InputEventJoypadButton:
        get_parent().start_game()
