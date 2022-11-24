extends CharacterBody2D

class_name RTSTestUnit

var speed = 100.0

var rng = RandomNumberGenerator.new()
var _timer: Timer = Timer.new()

@onready var _agent: NavigationAgent2D = $NavigationAgent2D

signal destination_reached(unit: RTSTestUnit)

func set_target(target: Vector2) -> void:
	_agent.set_target_location(target)
	$NavigationTarget.global_position = target

func init(_position: Vector2) -> RTSTestUnit:
	self.global_position = _position

	
	return self

func _ready() -> void:
#	_agent.path_changed.connect(on_path_changed)
	_agent.target_reached.connect(on_target_reached)
	_timer.set_wait_time(0.1)
	self.add_child(_timer)
	_timer.timeout.connect(_on_timer_timeout)

func _physics_process(_delta: float) -> void:
	var next_location = _agent.get_next_location()
	var v = (next_location - self.global_position).normalized() * speed
	
	_agent.set_velocity(v)
	self.velocity = v
	move_and_slide()
#	queue_redraw()

#func on_path_changed() -> void:
#	queue_redraw()

#func _draw():
#	var inv = get_global_transform().inverse();
#	draw_set_transform(inv.origin, inv.get_rotation(), inv.get_scale());
#	var paths: Array = _agent.get_nav_path()
#	for i in range(paths.size()):
#		if i < _agent.get_nav_path_index(): continue
#		draw_line(self.to_global(paths[i-1]) - self.global_position, self.to_global(paths[i]) - self.global_position, Color(1,0,0, 1.0))

func on_target_reached() -> void:
	# workaround until my MR gets merged
	_timer.start()

func _on_timer_timeout() -> void:
	_timer.stop()
	destination_reached.emit(self)
