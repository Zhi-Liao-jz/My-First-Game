extends Bullet

func _ready() -> void:
	super()
	move_component.can_move=true
	move_component.move_state=MoveComponent.move_states.uniform

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent and area.can_be_damaged:
			var attack = Attack.new()
			attack.attack_damage=attack_damage
			area.damage(attack)
			queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
