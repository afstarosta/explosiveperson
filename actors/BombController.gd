extends Node

onready var bomb_scene:PackedScene = load("res://scenes/player/Bomb.tscn")
onready var parent = get_parent()

func _physics_process(delta):
    if(parent.active):
        if Input.is_action_just_pressed("ui_bomb_" + str(parent.id)) && !reached_bomb_cap():
            plant_bomb()

func plant_bomb():
    var bomb = bomb_scene.instance()
   
    var tileset_coords = GameSettings.level.FGTilemap.world_to_map(parent.global_position)
    
    add_child(bomb)
    bomb.init(parent.stats.bomb_power)
    bomb.global_position = (tileset_coords * GameSettings.TILE_SIZE.x) + GameSettings.TILE_SIZE/2

func reached_bomb_cap():
    return get_child_count() >= parent.stats.max_bombs
