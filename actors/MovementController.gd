extends Node

const speed = 100

onready var parent = get_parent()
onready var sprite:AnimatedSprite = $"../AnimatedSprite"
var direction = "front"

func _physics_process(_delta):
    if(parent.active):
        handle_movement()
    
func handle_movement():
    var velocity = Vector2(0, 0)
    if Input.is_action_pressed("ui_up_" + str(parent.id)):
        velocity.y = -1
        direction = "back"
    if Input.is_action_pressed("ui_down_" + str(parent.id)):
        velocity.y = 1 
        direction = "front"
    if Input.is_action_pressed("ui_left_" + str(parent.id)):
        velocity.x = -1
        direction = "left"
    if Input.is_action_pressed("ui_right_" + str(parent.id)):
        velocity.x = 1
        direction = "right"
            
    parent.move_and_slide(velocity * speed)
    set_animation(velocity)

func hit():
    sprite.animation = "dead"
    set_physics_process(false)
    get_parent().deactivate()

func set_animation(velocity: Vector2):
    if(velocity.length() == 0):
        sprite.animation = "i_" + direction
    else:
        sprite.animation = "w_" + direction
