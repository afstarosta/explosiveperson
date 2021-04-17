extends StaticBody2D

var tilemap:TileMap
var cell_coord
var powerup_scene:PackedScene = load("res://scenes/PowerUp.tscn")

func hit():
    tilemap.set_cellv(cell_coord, -1)
    get_node("/root/Main/explosionController").brick_explosion(self.global_position)
    spawn_powerup()
    queue_free()

func spawn_powerup():
    randomize()
    if randf() <= .8:
        var powerup:StaticBody2D = powerup_scene.instance()
    
        powerup.position.x = (cell_coord.x * GameSettings.TILE_SIZE.x) + GameSettings.TILE_SIZE.x/2
        powerup.position.y = (cell_coord.y * GameSettings.TILE_SIZE.y) + GameSettings.TILE_SIZE.y/2
        
        powerup.init()
        GameSettings.powerup_container.add_child(powerup)
