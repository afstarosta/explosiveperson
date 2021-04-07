extends Node2D

onready var explosion_animation:PackedScene = load("res://scenes/particles/simpleExplosion.tscn")
onready var brick_explosion_scene:PackedScene = load("res://scenes/particles/brickExplosion.tscn")

func simple_explosion(target_position: Vector2):
    var explosion:CPUParticles2D = explosion_animation.instance()
    explosion.global_position = target_position
    add_child(explosion)
    explosion.emitting = true

func brick_explosion(target_position: Vector2):
    var explosion:CPUParticles2D = brick_explosion_scene.instance()
    explosion.global_position = target_position
    add_child(explosion)
    explosion.emitting = true
