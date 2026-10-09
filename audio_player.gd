extends Node

@export var mixing_board: Node3D

@onready var track1: AudioStreamPlayer3D = $Thriller
@onready var track2: AudioStreamPlayer3D = $Ghostbusters

var mixer: MixConsole
var record1: StaticBody3D
var record2: StaticBody3D


func _ready() -> void:
	if mixing_board:
		if mixing_board.has_node("Slider"):
			mixer = mixing_board.get_node("Slider")
			mixer.mix_changed.connect(_change_mix)
		if mixing_board.has_node("Record1"):
			record1 = mixing_board.get_node("Record1")
		if mixing_board.has_node("Record2"):
			record2 = mixing_board.get_node("Record2")

func _change_mix(mix: float) -> void:
	prints("new mix:", mix)
	if record1.record_playing && !track1.playing:
		track1.playing = true
	elif !record1.record_playing:
		track1.playing = false
	if record2.record_playing && !track2.playing:
		track2.playing = true
	elif !record2.record_playing:
		track2.playing = false

	# there must be a better way to do this
	var track1_vol = 1.0 - (0.0 + mix)
	var track2_vol = 1.0 - (1.0 - mix)
	prints("t1 vol", track1_vol, "t2 vol", track2_vol)
	track1.volume_linear = track1_vol
	track2.volume_linear = track2_vol
