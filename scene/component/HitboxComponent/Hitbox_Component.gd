extends Area2D
class_name HitboxComponent
@onready var enemy : Node2D = get_parent()
@onready var health_component : HealthComponent = get_parent().get_node("HealthComponent")
@onready var animation_player : AnimationPlayer = get_parent().get_node("Sprite2D/AnimationPlayer")

func damage(attack:Attack):
	if enemy.weight>0 :
		enemy.position.x+=attack.force/enemy.weight*30
	if health_component:
		health_component.damage(attack)
		if animation_player:
			animation_player.play("flash")
