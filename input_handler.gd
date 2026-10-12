extends Node

@onready var album_handler: AlbumHandler = get_node("/root/MainScene/AlbumHandler")

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("select_album"):
		album_handler.select_album()

	if Input.is_action_just_pressed("next_album"):
		album_handler.next_album()
	if Input.is_action_just_pressed("prev_album"):
		album_handler.prev_album()

	if Input.is_action_just_pressed("return_album"):
		prints("escape pressed")
		album_handler.return_album()

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		prints("unhandled escape")
