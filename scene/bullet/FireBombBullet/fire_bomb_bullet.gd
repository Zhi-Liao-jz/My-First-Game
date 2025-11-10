extends Bullet
var target_position : Vector2

func _physics_process(delta: float) -> void:
	super(delta)
	rotate(PI*delta)

func _on_area_entered(area: Area2D) -> void:
	super(area)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
