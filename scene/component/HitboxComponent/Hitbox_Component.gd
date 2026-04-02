extends Area2D
class_name HitboxComponent
@onready var enemy : Node2D = get_parent()
@onready var health_component : HealthComponent = get_parent().get_node("HealthComponent")
@export var animation_player : AnimationPlayer
var can_be_damaged = true

func damage(attack:Attack):
	if can_be_damaged == false:
		return
	if enemy.param.weight>0 :
		enemy.position.x+=attack.force/enemy.param.weight*30
	if health_component:
		health_component.damage(attack)
		if animation_player:
			animation_player.play("flash")
