extends Node2D

onready var explosion_animation:PackedScene = load("res://scenes/player/simpleExplosion.tscn")

func create_explosion(target_position: Vector2):
    var explosion:CPUParticles2D = explosion_animation.instance()
    explosion.global_position = target_position
    add_child(explosion)
    explosion.emitting = true
    #print(explosion.position)
