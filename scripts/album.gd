extends Node3D

@onready var origin_position: Vector3 = position
@onready var record = $Record

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
			# TODO: Need to add a marker in the scene for the album to hit, so all the records will arrive at the same spot
			var target_quat = Quaternion.from_euler(target_euler)
			var tween2 = get_tree().create_tween()
			tween2.tween_property(self, "quaternion", target_quat, 1.2)\
					.set_trans(Tween.TRANS_BACK)\
					.set_ease(Tween.EASE_OUT)
			tween2.tween_callback(func(): updateState(State.FLOATING))

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
