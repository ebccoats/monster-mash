extends StaticBody3D

@onready var collision_shape: CollisionShape3D = $CollisionShape3D

var mouse_over = false
var record_playing = false
var rpm = 45.0

func _ready() -> void:
	input_ray_pickable = true

func _mouse_enter() -> void:
	mouse_over = true

func _mouse_exit() -> void:
	mouse_over = false

func _input(event: InputEvent) -> void:
	if mouse_over:
		if event is InputEventMouseButton && event.pressed:
			if !record_playing:
				record_playing = true
			else:
				record_playing = false

func _process(delta: float) -> void:
	if record_playing:
		var rotation_step = ((TAU * rpm) / 60) / 20
		rotate_y(-rad_to_deg(rotation_step * delta))
