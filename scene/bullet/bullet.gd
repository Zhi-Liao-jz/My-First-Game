extends Area2D
class_name Bullet
@onready var move_component : MoveComponent = $MoveComponent

@export var init_speed : float
@export var move_state : MoveComponent.move_states
@onready var speed : float :
	set(value):
		speed=value
		if move_component :
			move_component.speed=speed
@export var attack_param : AttackParam
var attack : AttackParam
var direction : Vector2 :
	set(value):
		direction = value.normalized()
		if move_component :
			move_component.direction=direction

var damage_mutiple : float = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	attack=attack_param.duplicate()
	speed = init_speed
	move_component.speed=speed
	move_component.direction=direction
	move_component.move_state=move_state

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	pass

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent and area.can_be_damaged:
		area.damage(attack)
		queue_free()
