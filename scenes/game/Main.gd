extends Node2D

onready var player_scene:PackedScene = load("res://scenes/player/Player.tscn")
var players = []
var player_devices = []
var game_running = false

func spawn_player(player_id):    
    var spawn_points = $Level.get_spawn_points()
    var player = player_scene.instance()
    $Players.add_child(player)
    player.position = spawn_points[len(players)].global_position
    player.joypad_device_id = player_id
    players.append(player)
    player_devices.append(player_id)
    player.activate()

func _physics_process(delta):
    if(len(players) > 1):
        game_running = true
        
    if(game_running and !has_enough_active_players_to_run()):
        game_running = false
        end_game()

func end_game():
    yield(get_tree().create_timer(1.0), "timeout")
    get_tree().call_group("player", "deactivate")

func has_enough_active_players_to_run():
    return count_active_players() > 1

func count_active_players():
    var count = 0
    for player in players:
        if(player.active):
            count += 1
    return count

func _input(event):
    if !game_running && (event is InputEventJoypadButton):
        if(player_devices.find(event.device) == -1):
            spawn_player(event.device)
        
        

