extends Area2D
class_name HitboxComponent
@export var enemy : Node2D
var health_component : HealthComponent 
var animation_player : AnimationPlayer

func _ready() -> void:
	enemy=get_parent()
	health_component = enemy.get_node("HealthComponent")
	animation_player = enemy.get_node("Sprite2D/AnimationPlayer")

func damage(attack:Attack):
	if health_component:
		health_component.damage(attack)
		if animation_player:
			animation_player.play("flash")
