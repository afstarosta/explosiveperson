extends Node2D

var power_up_method: FuncRef

enum powerup_types {
    MOVESPEED,
    MAXBOMB,
    BOMBPOWER,
    SHIELD,
}

func apply_powerup(stats: Node):
    print(power_up_method.to_string())
    power_up_method.call_func(stats)
    print("applied pu")
    queue_free()

func init(powerup_type=null):
    if powerup_type == null:
        powerup_type = randi() % powerup_types.size()
        
    if powerup_type == powerup_types.MOVESPEED:
        power_up_method = funcref(self, "apply_movespeed")
        $MOVESPEED.visible = true
    if powerup_type == powerup_types.MAXBOMB:
        power_up_method = funcref(self, "apply_maxbomb")
        $MAXBOMB.visible = true
    if powerup_type == powerup_types.BOMBPOWER:
        power_up_method = funcref(self, "apply_bombpower")
        $BOMBPOWER.visible = true
    if powerup_type == powerup_types.SHIELD:
        power_up_method = funcref(self, "apply_shield")
        $SHIELD.visible = true
    
func apply_movespeed(stats: Node):
    stats.move_speed += 50

func apply_maxbomb(stats: Node):
    stats.max_bombs += 1
    
func apply_bombpower(stats: Node):
    stats.bomb_power += 1
    
func apply_shield(stats: Node):
    stats.lives += 1

func hit():
    queue_free()
    
