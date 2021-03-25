extends Node2D

const bomb_duration = 3.0

onready var collider:CollisionShape2D = $CollisionShape2D

var timer = 0.0
var power = 2

onready var raycasts = get_node("raycasts").get_children()


func _ready():
    for raycast in raycasts:
        raycast.cast_to = raycast.cast_to * power * 32
    
func _physics_process(delta):
    timer += delta

    if(timer >= bomb_duration):
        explode()
        queue_free()


func explode():
    for raycast in raycasts:
        raycast.cast_to *= power * 32
        print(raycast.cast_to)
        var colliding = raycast.get_collider()
        print(raycast.is_colliding())
        if(colliding and colliding.has_method("explode")):
            colliding.explode()
           

func _on_Area2D_body_exited(_body):

    collider.set_deferred("disabled",false)
