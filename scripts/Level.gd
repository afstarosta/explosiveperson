extends Node2D

onready var FGTilemap:TileMap = $FG

onready var unbreakable_wall_scene:PackedScene = load("res://scenes/tiles/UnbreakableWall.tscn")
onready var breakable_wall_scene:PackedScene = load("res://scenes/tiles/BreakableWall.tscn")

var TILE_SIZE

func _ready():
    GameSettings.TILE_SIZE = FGTilemap.get_cell_size()
    GameSettings.level = self
    
    var cells = FGTilemap.get_used_cells_by_id(0)
    create_unbreakable_walls(cells)
    cells = FGTilemap.get_used_cells_by_id(1)
    create_breakable_walls(cells)

func create_unbreakable_walls(cells):
    for cell in cells: 
        var wall = unbreakable_wall_scene.instance()
        add_child(wall)
        wall.position = Vector2(cell.x * FGTilemap.cell_size.x, cell.y * FGTilemap.cell_size.y)
        
    
func create_breakable_walls(cells):
    for cell in cells: 
        var wall = breakable_wall_scene.instance()
        add_child(wall)
        wall.position = Vector2(cell.x * FGTilemap.cell_size.x, cell.y * FGTilemap.cell_size.y)
        wall.cell_coord = cell
        wall.tilemap = FGTilemap

func get_spawn_points():
    return get_node("SpawnPoints").get_children()
