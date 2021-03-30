extends Node2D

onready var bomb_scene:PackedScene = load("res://scenes/player/Bomb.tscn")
onready var player_body:KinematicBody2D = get_parent().get_node("PlayerBody")

func _physics_process(delta):
    if Input.is_action_just_pressed("ui_accept"):
        plant_bomb()


func plant_bomb():
    var bomb = bomb_scene.instance()
   
    bomb.position = Vector2(round(player_body.position.x / GameSettings.TILE_SIZE.x) * GameSettings.TILE_SIZE.x, round(player_body.position.y / GameSettings.TILE_SIZE.y) * GameSettings.TILE_SIZE.y)
    add_child(bomb)
