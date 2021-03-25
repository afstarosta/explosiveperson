extends KinematicBody2D

const speed = 100

onready var bomb_scene:PackedScene = load("res://Bomb.tscn")

func _physics_process(_delta):
    handle_movement()
    handle_action()
    
func handle_action():
    if Input.is_action_just_pressed("ui_accept"):
        plant_bomb()

func plant_bomb():
    var bomb = bomb_scene.instance()
   
    bomb.position = Vector2(round(self.position.x / 32) * 32, round(self.position.y / 32) * 32)
    get_parent().call_deferred("add_child", bomb)
    
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
    
