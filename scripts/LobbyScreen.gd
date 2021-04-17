extends Node2D

var players = []

func _process(_delta):
    if(should_start_game()):
        get_parent().start_match(players)

func _input(event):
    if event is InputEventJoypadButton and event.get_button_index() == JOY_START:
        if(players.find(event.device) == -1 and len(players) < GameSettings.MAX_PLAYERS):
            set_player_ready_box(len(players), event.device)
            players.append(event.device)

func set_player_ready_box(index: int, player_device: int):

    var player_box = $PlayerBoxes.get_children()[index]
    player_box.has_player = true
    player_box.player_device_id = player_device

func should_start_game():
    return len(players) > 0 and are_all_players_ready()

func are_all_players_ready():
    var player_boxes = $PlayerBoxes.get_children()
    for index in range(len(players)):
        if(!player_boxes[index].is_ready):
            return false
    return true
