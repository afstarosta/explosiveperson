extends Node2D

var number_of_players = 4

onready var player_scene:PackedScene = load("res://scenes/player/Player.tscn")
var players = []
var game_running = true

func _ready():
    start_game()
    
func start_game():
    var spawn_points = $Level.get_spawn_points()
    for player_slot in range(number_of_players):
        var player = player_scene.instance()
        $Players.add_child(player)
        player.position = spawn_points[player_slot].global_position
        player.activate()
        players.append(player)

func _physics_process(delta):
    if(!has_enough_active_players_to_run() and game_running):
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


