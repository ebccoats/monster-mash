extends Node3D

@onready var sprite: Sprite3D = $Sprite3D

var neutral_basis: Basis
var frame_counter = 0

func _ready() -> void:
	neutral_basis = basis


func _physics_process(delta: float) -> void:
	basis = neutral_basis
	frame_counter += frame_counter
	if dance: 
		rotate_z(5.0)
		dance = false
	else:
		rotate_z(-5.0)
		dance = true
