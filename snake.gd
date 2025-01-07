extends Node2D

var direction = Vector2.ZERO
var snake_position = Vector2(100, 100)
var block_size = Vector2(50, 50)
var tail = [Vector2(0,0)]

var movement = {
    "ui_down" : Vector2.DOWN,
    "ui_up" : Vector2.UP,
    "ui_right" : Vector2.RIGHT,
    "ui_left" : Vector2.LEFT,
}
func step():
    #print("tail is", tail)
    tail[0] += direction * 50
    queue_redraw()
    await(get_tree().create_timer(0.25).timeout)
    step()
    
func _ready() -> void:
    #print(type_string(typeof(movement)))
    step()

func _process(delta: float) -> void:
    if Input.is_action_just_pressed("ui_accept"):
        tail.append(tail[0])
    if Input.is_action_just_pressed("ui_cancel"):
        get_tree().quit()
    for i in movement:
        if Input.is_action_just_pressed(i):
            direction = movement[i]
func _draw():
    var black_screen = Rect2(0, 0, 800, 800)
    draw_rect(black_screen, Color.BLACK)
    
    for i in tail:
        var snake_square = Rect2(i, block_size)
        draw_rect(snake_square, Color.LIME)
