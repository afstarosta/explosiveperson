extends StaticBody2D

var tilemap:TileMap
var cell_coord
var powerup_scene:PackedScene = load("res://scenes/PowerUp.tscn")

func _ready():
	yield(get_tree().create_timer(3.0), "timeout")
	hit()

func hit():
	tilemap.set_cellv(cell_coord, -1)
	get_node("/root/Main/explosionController").brick_explosion(self.global_position)
	spawn_powerup()
	queue_free()

func spawn_powerup():
	if randf() > .8:
		var powerup:StaticBody2D = powerup_scene.instance()
		powerup.position = cell_coord * GameSettings.TILE_SIZE * 1.5
		powerup.init(powerup.powerup_types.MOVESPEED)
		GameSettings.powerup_container.add_child(powerup)
