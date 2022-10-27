extends Camera2D

const MIN_ZOOM: float = 0.1
const MAX_ZOOM: float = 5.0
const ZOOM_INCREMENT: float = 0.1
const ZOOM_RATE: float = 1.0

var _target_zoom: float = 2
var _t: float = 1.0

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.is_action_pressed("drag", true):
			global_position -= event.relative / zoom
		if Input.is_action_pressed("right_click", true):
			global_position -= event.relative / zoom
	
	if event is InputEventMouseButton:
		if Input.is_action_pressed("mouse_wheel_scroll_up", true):
			zoom_in()
		if Input.is_action_pressed("mouse_wheel_scroll_down", true):
			zoom_out()

func _physics_process(delta: float) -> void:
	_t = clamp(_t, 1.0, _t + ZOOM_RATE * delta)
	zoom = zoom.lerp(_target_zoom * Vector2.ONE, _t)
	set_physics_process(_t < 1.0)

func zoom_in() -> void:
	_t = 0.0
	_target_zoom = max(_target_zoom - (ZOOM_INCREMENT * _target_zoom), MIN_ZOOM)
	set_physics_process(true)
	
func zoom_out() -> void:
	_t = 0.0
	_target_zoom = min(_target_zoom + (ZOOM_INCREMENT * _target_zoom), MAX_ZOOM)
	set_physics_process(true)
