extends Node

@export var album: Node3D

@onready var record: Node3D = album.get_node("Record")

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("select_album"):
		album.interact()

	if Input.is_action_just_pressed("roll_out_record"):
		record.interact()
		prints("i just pressed")
