extends StaticBody2D

var tilemap:TileMap
var cell_coord

func hit():
    tilemap.set_cellv(cell_coord, -1)
    get_node("/root/Main/explosionController").brick_explosion(self.global_position)
    queue_free()
