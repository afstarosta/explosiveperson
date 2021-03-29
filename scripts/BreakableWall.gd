extends StaticBody2D

var tilemap:TileMap
var cell_coord

func hit():
    tilemap.set_cellv(cell_coord, -1)
    queue_free()
