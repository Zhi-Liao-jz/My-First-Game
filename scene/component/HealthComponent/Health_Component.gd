extends Node
class_name HealthComponent
@export var max_health : float
@onready var enemy : Node2D = get_parent()
var health :float

func _ready() -> void:
	health=max_health

func damage(attack:Attack):
	health-=attack.attack_damage
	if health<=0:
		enemy.get_node("StateMachine").on_child_transition(null,"Dying")
