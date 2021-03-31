extends Node2D

onready var bomb_scene:PackedScene = load("res://scenes/player/Bomb.tscn")
onready var player_body:KinematicBody2D = get_parent().get_node("PlayerBody")

func _physics_process(delta):
    if(get_parent().active):
        if Input.is_action_just_pressed("ui_accept"):
            plant_bomb()


func plant_bomb():
    var bomb = bomb_scene.instance()
   
    var tileset_coords = GameSettings.level.FGTilemap.world_to_map(player_body.global_position)

    add_child(bomb)
    bomb.global_position = (tileset_coords * GameSettings.TILE_SIZE.x) + GameSettings.TILE_SIZE/2
