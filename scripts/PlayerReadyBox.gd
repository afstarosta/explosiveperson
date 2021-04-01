extends PanelContainer

var has_player = false
var player_device_id = -1
var is_ready = false

func _process(delta):
    if(has_player):
        self.modulate = Color("99ff44")

func _input(event):
    if event is InputEventJoypadButton and event.device == player_device_id and event.get_button_index() == JOY_START and event.is_pressed():
        is_ready = true
        $ready.visible = is_ready

    if event is InputEventJoypadButton and event.device == player_device_id and event.get_button_index() == JOY_SELECT and event.is_pressed():
        is_ready = false
        $ready.visible = is_ready
