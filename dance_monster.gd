extends Node3D

@onready var sprite: Sprite3D = $Sprite3D

@export var dance_frequency: float = 10.0
@export var dance_amplitude: float = 0.5

var dance_time: float = 0.0
var origin: Vector3

var neutral_basis: Basis
var frame_counter = 0.0

func _ready() -> void:
	origin = global_position

func _process(delta: float) -> void:
	dance_time += delta
	dance(dance_time)

	

func dance(time: float) -> void:
	var dance_position = global_transform.origin
	global_position.y = origin.y + sin(time * dance_frequency) * dance_amplitude
	global_position.x = origin.x + cos(time * dance_frequency / 2) * dance_amplitude
