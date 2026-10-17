
extends CharacterBody3D

@export var speed: float = 5.0
@export var jump_velocity: float = 4.5
@export var mouse_sensitivity: float = 0.002

var gravity: float = 9.8

func _physics_process(delta: float) -> void:
    if not is_on_floor():
        velocity.y -= gravity * delta

    if Input.is_action_just_pressed("jump") and is_on_floor():
        velocity.y = jump_velocity

    var input_dir := Input.get_vector(
        "move_left", "move_right",
        "move_forward", "move_back"
    )
    var direction := transform.basis * Vector3(
        input_dir.x, 0, input_dir.y
    )

    if direction.length() > 0:
        direction = direction.normalized()

    velocity.x = direction.x * speed
    velocity.z = direction.z * speed
    move_and_slide()
