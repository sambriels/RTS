extends Camera2D

const MIN_ZOOM: float = 0.1
const MAX_ZOOM: float = 5.0
const ZOOM_INCREMENT: float = 0.1
const ZOOM_RATE: float = 1.0
const POSITION_OFFSET_FACTOR: float = 0.1

var _target_zoom: float = 1.0
var _target_position: Vector2 = Vector2()
var _t: float = 1.0

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.is_action_pressed("drag", true):
			global_position -= event.relative / zoom
		if Input.is_action_pressed("right_click", true):
			global_position -= event.relative / zoom
		_target_position = global_position
	
	if event is InputEventMouseButton:
		if Input.is_action_pressed("mouse_wheel_scroll_up", true):
			zoom_in()
		if Input.is_action_pressed("mouse_wheel_scroll_down", true):
			zoom_out()

func _physics_process(delta: float) -> void:
	_t = clamp(_t, 1.0, _t + ZOOM_RATE * delta)
	zoom = zoom.lerp(_target_zoom * Vector2.ONE, _t)
#	global_position = global_position.lerp(_target_position, _t)
	set_physics_process(_t < 1.0)

func get_target_position_offset() -> Vector2:
	var local_mouse_pos = get_local_mouse_position()
	return local_mouse_pos.normalized() * local_mouse_pos.length() * POSITION_OFFSET_FACTOR

func zoom_in() -> void:
	_t = 0.0
	_target_zoom = max(_target_zoom - (ZOOM_INCREMENT * _target_zoom), MIN_ZOOM)
#	_target_position += get_target_position_offset()
	set_physics_process(true)
	
func zoom_out() -> void:
	_t = 0.0
	_target_zoom = min(_target_zoom + (ZOOM_INCREMENT * _target_zoom), MAX_ZOOM)
#	_target_position += get_target_position_offset()
	set_physics_process(true)
