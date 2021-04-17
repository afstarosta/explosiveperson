extends Node2D

var TILE_SIZE:Vector2 = Vector2(0, 0)

var level:Node2D
var powerup_container:Node2D

const MAX_PLAYERS = 4


const player_input_template = [
    ["ui_left_", JOY_DPAD_LEFT],
    ["ui_right_", JOY_DPAD_RIGHT],
    ["ui_up_", JOY_DPAD_UP],
    ["ui_down_", JOY_DPAD_DOWN],
    ["ui_bomb_", JOY_DS_A],
   ]

func map_player_input(player_id: int, player_device: int):
    for input in player_input_template:
        var input_event:InputEventJoypadButton = InputEventJoypadButton.new()
        input_event.button_index = input[1]
        input_event.device = player_device
        var action_name = input[0] + str(player_id)
        InputMap.add_action(action_name)
        InputMap.action_add_event(action_name, input_event)
