
extends CanvasLayer

signal move_input(direction: Vector2)
signal look_input(delta: Vector2)

var move_touch := -1
var look_touch := -1
var move_origin := Vector2.ZERO

func _input(event: InputEvent) -> void:
    if event is InputEventScreenTouch:
        if event.pressed:
            if event.position.x < 400 and move_touch == -1:
                move_touch = event.index
                move_origin = event.position
            elif look_touch == -1:
                look_touch = event.index
        else:
            if event.index == move_touch:
                move_touch = -1
                move_input.emit(Vector2.ZERO)
            if event.index == look_touch:
                look_touch = -1

    elif event is InputEventScreenDrag:
        if event.index == move_touch:
            var direction = (event.position - move_origin).limit_length(80.0) / 80.0
            move_input.emit(direction)
        elif event.index == look_touch:
            look_input.emit(event.relative)
