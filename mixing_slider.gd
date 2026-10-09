extends MeshInstance3D
class_name MixConsole

@onready var slider_handle: StaticBody3D = $SliderHandle
@onready var slider_label: Label3D = $SliderHandle/Label3D

signal mix_changed(mix: float)

var mix = 0.5
var zero_point: Vector3
var dragging = false
var camera: Camera3D

func _ready() -> void:
	slider_handle.input_ray_pickable = true
	zero_point = slider_handle.global_position
	camera = get_viewport().get_camera_3d()

func _input(event: InputEvent) -> void:
	if slider_handle.mouse_entered: 
		if event is InputEventMouseMotion and dragging:
			var slider_width = get_aabb().size.x
			var slider_start = global_position.x - (slider_width / 2)
			var slider_end = global_position.x + (slider_width / 2)
			var slider_length = abs(slider_end - slider_start)


			var local_zero: Vector3 = camera.to_local(slider_handle.global_position)
			var z_from_camera: float = -local_zero.z
			var mouse_in_world = camera.project_position(event.position, z_from_camera)




			slider_handle.global_position.x = mouse_in_world.x

			if mouse_in_world.x > slider_end:
				slider_handle.global_position.x = slider_end
			elif mouse_in_world.x < slider_start:
				slider_handle.global_position.x = slider_start

			mix = -snapped((slider_start - slider_handle.global_position.x) / slider_width, 0.01)
			slider_label.text = str(int(mix * 100)) + "%"
			mix_changed.emit(mix)

			
		
		elif event is InputEventMouseButton:
			if not dragging and event.pressed:
				dragging = true
		
			if dragging and not event.pressed:
				dragging = false
