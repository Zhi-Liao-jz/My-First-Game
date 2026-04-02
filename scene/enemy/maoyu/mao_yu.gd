extends Enemy


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	move_component.can_move=true
	move_component.move_state=MoveComponent.move_states.uniform
	move_component.direction=Vector2(-1,0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
