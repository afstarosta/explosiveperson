extends KinematicBody2D

const speed = 100


onready var bomb_container:Node2D = get_parent().get_node("BombContainer")

func _physics_process(_delta):
    handle_movement()
    
func handle_movement():
    var velocity = Vector2(0, 0)
    if Input.is_action_pressed("ui_up"):
        velocity.y = -1
    if Input.is_action_pressed("ui_down"):
        velocity.y = 1 
    if Input.is_action_pressed("ui_left"):
        velocity.x = -1
    if Input.is_action_pressed("ui_right"):
        velocity.x = 1
            
    var _a = move_and_slide(velocity * speed)
    
func hit():
    queue_free()
    
