extends Node3D

@export var song: AudioStreamPlayer3D
@export var label: Sprite3D

var state: State
var is_ready: bool = false 
var target_position_local: Vector3
var target_position_global: Vector3
var speed: float = 5.0

@onready var origin_position = position

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
			tween.tween_callback(func(): 
				updateState(State.ROLLED_OUT)
				is_ready = true
				)
		
		if state == State.ROLLED_OUT:
			# unparent from album, parent to targeted turntable
			return

		if state == State.PLAYING:
			# pass to parent turntable
			return

func return_to_sleeve() -> void:
	if is_ready:
		if state == State.ROLLED_OUT:
			prints("album asked to return to sleeve")
			is_ready = false
			var tween = create_tween()
			tween.tween_property(self, "position", origin_position, 0.1)
			tween.tween_callback(func(): 
				updateState(State.SLEEVED)
				visible = false
				is_ready = true
			)

	


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
