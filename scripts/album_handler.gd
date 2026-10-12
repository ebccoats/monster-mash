extends Node

class_name AlbumHandler

var albums: Array

func _ready() -> void:
	var crate: Node3D = get_node("/root/MainScene/Records/Albums")
	for child in crate.get_children():
		albums.append(child)

	prints(albums)
	
func prev_album() -> void:
	for album in albums: 
		if album.state == album.State.FLOATING || !album.is_ready:
			return
	for album in albums:
		if album.state == album.State.UPRIGHT:
			var prev_index = max(0, albums.find(album) - 1) # clamp to not go lower than zero
			if albums[prev_index] != album:
				album.tilt_neg()
				albums[prev_index].upright()
			prints("prev album from", album, ":", albums[prev_index])

func next_album() -> void:
	for album in albums: 
		if album.state == album.State.FLOATING || !album.is_ready:
			return
	for album in albums:
		if album.state == album.State.UPRIGHT:
			var next_index = min(albums.find(album) + 1, albums.size() - 1) # clamp to not go higher than array indexes
			if albums[next_index] != album:
				album.tilt_pos()
				albums[next_index].upright()

			prints("next album from", album, ":", albums[next_index])

func select_album() -> void:
	for album in albums: 
		if album.state == album.State.FLOATING || !album.is_ready:
			return
	for album in albums:
		if album.state == album.State.UPRIGHT && album.is_ready:
			album.interact()

func return_album() -> void:
	for album in albums:
		if album.state == album.State.FLOATING && album.is_ready:
			album.return_to_milkcrate()
