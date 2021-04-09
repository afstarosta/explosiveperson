extends Sprite

var initial_position:Vector2
var is_active:bool = true
var original_cell:Vector2
var level_host:Object

func start(position: Vector2, cell: Vector2, host: Object):
    self.initial_position = position
    self.original_cell = cell
    self.level_host = host
    self.position = position
    self.position.y -= 100
    
func _process(delta):
    if(is_active):
        self.position.y += 5
        if (self.position == initial_position):
            self.level_host.set_wall_after_animation(original_cell)
            queue_free()
            
    
