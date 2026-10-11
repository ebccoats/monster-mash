extends Node3D

@export var song: AudioStreamPlayer3D
@export var label: Sprite3D

var state: State
var is_ready: bool = false 
var target_position_local: Vector3
var target_position_global: Vector3
var speed: float = 5.0

enum State {
	SLEEVED,
	ROLLED_OUT,
	PLAYING,
}

func _ready() -> void:
	visible = false
	state = State.SLEEVED
	is_ready = true

func interact() -> void:
	if is_ready:
		if state == State.SLEEVED:
			var aabb = $MeshInstance3D.get_aabb()
			var size_x = aabb.size.x
			var target_offset = size_x - (size_x / 6)
			target_position_local = position + Vector3(target_offset, 0, 0)
			is_ready = false
			visible = true
			prints("interaction fired", "position", position, "target_position", target_position_local)
			var tween = get_tree().create_tween()
			tween.tween_property(self, "position", target_position_local, 1.0)\
				.set_trans(Tween.TRANS_QUART)\
				.set_ease(Tween.EASE_IN_OUT)
			tween.tween_callback(func(): updateState(State.ROLLED_OUT))
		
		if state == State.ROLLED_OUT:
			# unparent from album, parent to targeted turntable
			return

		if state == State.PLAYING:
			# pass to parent turntable
			return

func interact_away() -> void:
	if is_ready:
		if state == State.ROLLED_OUT:
			var aabb = $MeshInstance3D.get_aabb()
			var size_x = aabb.size.x
			var target_offset = size_x - (size_x / 4)
			target_position_local = position - Vector3(target_offset, 0, 0)
			is_ready = false
			state = State.PLAYING # not-ready PLAYING means return to album cover and deactivate self

		if state == State.PLAYING:
			# go back into album cover, unparent from turntable, parent to album cover
			return


func _process(delta: float) -> void:
	if !is_ready: # means animation is happening
		match state: 
			State.SLEEVED:
				prints("position", position, "target", target_position_local)
				# position = position.lerp(target_position_local, speed * delta)
				# if position.distance_to(target_position_local) < 0.01:
				# 	position = target_position_local
				# 	state = State.ROLLED_OUT
				# 	is_ready = true
				#
			State.ROLLED_OUT: # only moving towards turntable
				# animate position towards parent thru lerp
				# slerp rotation towards target
				return

			State.PLAYING: # only return to album cover
				# animate towards global rendezvous point with album cover
				# when global rendezvous point reached, reparent to album cover
				# reenter album cover, become invisible/inactive when centered in album cover
				return

				
func updateState(target_state: State) -> void:
	state = target_state
	prints("state", state)
