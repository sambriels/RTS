extends Node2D

var dragging: bool = false # Are we currently dragging?
var drag_start = Vector2.ZERO # Location where drag began
var select_rect = RectangleShape2D.new() # Collision shape for drag box

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("left_click", true):
			dragging = true
			drag_start = event.position
		if Input.is_action_just_released("left_click", true):
			dragging = false
			queue_redraw()

	if event is InputEventMouseMotion and dragging:
		queue_redraw()

func _draw() -> void:
	if dragging:
		draw_rect(Rect2(drag_start, get_global_mouse_position() - drag_start), Color(0,0,0, 0.2), true)
