extends Node2D

onready var FGTilemap:TileMap = $farm_FG

onready var breakable_wall_scene:PackedScene = load("res://scenes/tiles/BreakableWall.tscn")
onready var falling_wall_scene:PackedScene = load("res://fallingSprite.tscn")

var TILE_SIZE
var has_finished_animations

signal level_ready

func _ready():
    GameSettings.TILE_SIZE = FGTilemap.get_cell_size()
    GameSettings.level = self
    
    var breakable_walls = FGTilemap.get_used_cells_by_id(1)
    for cell in breakable_walls:
        FGTilemap.set_cellv(cell, -1)
        
    create_breakable_walls(breakable_walls)    
    play_falling_animation(breakable_walls)

func _process(delta):
    if has_finished_animations && $AnimatedTiles.get_child_count() == 0:
        emit_signal("level_ready")
        set_physics_process(false)

func play_falling_animation(cells):
    for cell in cells:
        var falling_wall = falling_wall_scene.instance()
        falling_wall.start(cell * GameSettings.TILE_SIZE, cell, self)
        $AnimatedTiles.add_child(falling_wall)
        yield(get_tree().create_timer(0.01), "timeout")
    has_finished_animations = true
    
func set_wall_after_animation(cell):
    FGTilemap.set_cellv(cell, 1)

func create_breakable_walls(cells):
    for cell in cells: 
        var wall = breakable_wall_scene.instance()
        add_child(wall)
        wall.position = Vector2(cell.x * FGTilemap.cell_size.x, cell.y * FGTilemap.cell_size.y)
        wall.cell_coord = cell
        wall.tilemap = FGTilemap

func get_spawn_points():
    return get_node("SpawnPoints").get_children()
