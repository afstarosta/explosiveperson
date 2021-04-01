extends KinematicBody2D

const speed = 100

onready var sprite:AnimatedSprite = $AnimatedSprite
onready var parent = get_parent()
var direction = "front"

func _physics_process(_delta):
    if(parent.active):
        handle_movement()
    
func handle_movement():
    print(parent.joypad_device_id)
    var velocity = Vector2(0, 0)
    if Input.is_joy_button_pressed(parent.joypad_device_id, JOY_DPAD_UP):
        velocity.y = -1
        direction = "back"
    if Input.is_joy_button_pressed(parent.joypad_device_id, JOY_DPAD_DOWN):
        velocity.y = 1 
        direction = "front"
    if Input.is_joy_button_pressed(parent.joypad_device_id, JOY_DPAD_LEFT):
        velocity.x = -1
        direction = "left"
    if Input.is_joy_button_pressed(parent.joypad_device_id, JOY_DPAD_RIGHT):
        velocity.x = 1
        direction = "right"
            
    var _a = move_and_slide(velocity * speed)
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
