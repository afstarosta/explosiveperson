extends Node2D

const bomb_duration = 3.0

onready var collider:CollisionShape2D = $CollisionShape2D
onready var explosionController:Node2D

var timer = 0.0
var power = 2

onready var raycasts = get_node("raycasts").get_children()

func _ready():
    explosionController = get_node("/root/Main/explosionController")

    for raycast in raycasts:
        raycast.cast_to = raycast.cast_to * power * GameSettings.TILE_SIZE.x
    
func _physics_process(delta):
    timer += delta

    if(timer >= bomb_duration):
        explode()
        queue_free()

func hit():
    timer = bomb_duration
    
func explode():
    for raycast in raycasts:
        var explosion_edge = raycast.global_position + raycast.cast_to 
        while raycast.is_colliding():
            var colliding = raycast.get_collider()
            if(colliding and colliding.has_method("hit")):
                colliding.hit()
            
            if(colliding.is_in_group("wall")):
                raycast.enabled = false
                explosion_edge = colliding.position + GameSettings.TILE_SIZE/2
                break
                
            raycast.add_exception(colliding)
            raycast.force_raycast_update()
        
        explosion_effect(raycast.global_position, explosion_edge)
        
func _on_Area2D_body_exited(_body):
    collider.set_deferred("disabled",false)

func explosion_effect(from_position:Vector2, to_position:Vector2):
    var direction = from_position.direction_to(to_position)
    var explosion_position = from_position

    print(explosion_position.distance_to(from_position))
    while explosion_position.distance_to(to_position) >= 1:
        
        explosionController.simple_explosion(explosion_position)
        explosion_position += direction
    
