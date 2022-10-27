extends Node2D

@export_range(1, 120, 1) var number_of_units_to_spawn

const TestUnit = preload("res://units/test_unit.tscn")
var rng = RandomNumberGenerator.new()
var units: Array = []

func _get_random_location() -> Vector2:
	return Vector2(rng.randf_range(10.0, 400.0),rng.randf_range(10.0, 400.0))
	
func _process(_delta: float) -> void:
	$CanvasLayer/Label.set_text("Units spawned: %d" % units.size())

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("left_click"):
		# consume input on the viewport so it does not propagate
		get_tree().get_root().set_input_as_handled()
		
		for i in range(0, number_of_units_to_spawn):
			print("ehh hallo")
			var instance: RTSTestUnit = TestUnit.instantiate().init(_get_random_location())
			instance.destination_reached.connect(_on_test_unit_destination_reached)
			units.push_back(instance)
			add_child(instance)
			instance.set_target(_get_random_location())

func _on_test_unit_destination_reached(unit: RTSTestUnit) -> void:
	unit.set_target(_get_random_location())
