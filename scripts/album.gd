extends Node3D

@onready var origin_position: Vector3 = position
@onready var record = $Record

@export var label_sprite: Texture2D
@export var album_cover: Texture2D
@export var audio_player: AudioStreamPlayer3D

var is_ready: bool = true
var state: State
var height: float
var hover_marker: Marker3D

enum State {
	TILTED_POSITIVE,
	UPRIGHT,
	TILTED_NEGATIVE,
	SELECTED,
	FLOATING,
	}

func _ready() -> void:
	if rotation.x > 0:
		state = State.TILTED_POSITIVE
	elif rotation.x < 0:
		state = State.TILTED_NEGATIVE
	else:
		state = State.UPRIGHT

	var aabb = $MeshInstance3D.get_aabb()
	height = aabb.size.y

	hover_marker = find_parent("Records").get_node("AlbumHoverTarget")
	prints("hover target", hover_marker)

	if label_sprite:
		var record_label: Sprite3D = record.get_node("Sprite3D")
		record_label.texture = label_sprite

	if album_cover:
		var album_cover_image: Sprite3D = $Sprite3D
		album_cover_image.texture = album_cover



func interact() -> void:
	if is_ready:
		if state == State.UPRIGHT:
			var target_offset = origin_position.y + height
			is_ready = false
			var target_position_local = hover_marker.global_position 
			var target_position_overshoot = position + Vector3(0, target_offset, 0)
			var tween = get_tree().create_tween()
			tween.tween_property(self, "global_position", target_position_local, 1.0)\
					.set_trans(Tween.TRANS_BACK)\
					.set_ease(Tween.EASE_OUT)

			var target_euler = Vector3(deg_to_rad(-24.5), deg_to_rad(13.4), 0)
			var target_quat = Quaternion.from_euler(target_euler)
			var tween2 = get_tree().create_tween()
			tween2.tween_interval(0.4)
			tween2.tween_property(self, "quaternion", target_quat, 1.2)\
					.set_trans(Tween.TRANS_BACK)\
					.set_ease(Tween.EASE_OUT)
			tween2.tween_callback(func(): updateState(State.FLOATING))

func tilt_neg() -> void:
	if state == State.UPRIGHT && is_ready:
		is_ready = false
		var tween = create_tween()
		tween.set_parallel()
		tween.tween_property(self, "rotation", rotation + Vector3(deg_to_rad(-15), 0, 0), 0.2)
		tween.tween_property(self, "position", origin_position, 0.2)
		tween.tween_callback(func(): 
			updateState(State.TILTED_NEGATIVE)
			is_ready = true
			)

func tilt_pos() -> void:
	if state == State.UPRIGHT && is_ready:
		is_ready = false
		var tween = create_tween()
		tween.set_parallel()
		tween.tween_property(self, "rotation", rotation + Vector3(deg_to_rad(15), 0, 0), 0.2)
		tween.tween_property(self, "position", origin_position, 0.2)
		tween.tween_callback(func(): 
			updateState(State.TILTED_POSITIVE)
			is_ready = true
			)

func upright() -> void:
	if state == State.TILTED_POSITIVE or state == State.TILTED_NEGATIVE && is_ready:
		is_ready = false
		var tween = create_tween()
		tween.set_parallel()
		tween.tween_property(self, "rotation", Vector3(0, 0, 0), 0.2)
		tween.tween_property(self, "position", position + Vector3(0, height / 3, 0), 0.2)
		tween.tween_callback(func(): 
			updateState(State.UPRIGHT)
			is_ready = true
			)

func return_to_milkcrate() -> void:
	if state == State.FLOATING && is_ready:
		is_ready = false
		record.return_to_sleeve()
		prints("fired record.interact_away")
		var tween = create_tween()
		tween.set_parallel()
		tween.tween_property(self, "rotation", Vector3(0, 0, 0), 0.2)\
				.set_trans(Tween.TRANS_SPRING)
		tween.tween_property(self, "position", origin_position, 0.7)\
				.set_trans(Tween.TRANS_BACK)\
				.set_ease(Tween.EASE_IN_OUT)
		tween.tween_callback(func(): 
			updateState(State.UPRIGHT)
			is_ready = true
			)




func _process(delta: float) -> void:
	if !is_ready:
		if state == State.UPRIGHT:
			if position.y > origin_position.y + height / 2:
				record.interact()

	if is_ready:
		if state == State.FLOATING:
			return

func updateState(target_state: State) -> void:
	state = target_state
	if state == State.FLOATING:
		is_ready = true
