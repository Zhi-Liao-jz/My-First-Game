extends Bullet

func _ready() -> void:
	super()
	move_component.move_state=move_component.move_states.uniform


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
