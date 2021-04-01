extends Node2D

onready var player_scene:PackedScene = load("res://scenes/player/Player.tscn")
var players = []
var player_devices = []
var game_running = false

onready var start_screen_scene:PackedScene = load("res://screens/StartScreen.tscn")
var start_screen

onready var lobby_screen_scene:PackedScene = load("res://screens/LobbyScreen.tscn")
var lobby_screen

onready var level_scene:PackedScene = load("res://scenes/game/Level.tscn")
var level

func _ready():
    start_screen = start_screen_scene.instance()
    add_child(start_screen)

func start_game():
    start_screen.queue_free()
    lobby_screen = lobby_screen_scene.instance()
    add_child(lobby_screen)

func start_match(players):    
    lobby_screen.queue_free()
    level = level_scene.instance()
    add_child(level)
    
    for player_slot in range(len(players)):
        var spawn_points = level.get_spawn_points()
        var player = player_scene.instance()
        $Players.add_child(player)
        player.position = spawn_points[player_slot].global_position
        player.joypad_device_id = players[player_slot]
        player.id = player_slot
        players.append(player)
        player_devices.append(players[player_slot])
        GameSettings.map_player_input(player.id, player.joypad_device_id)
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

