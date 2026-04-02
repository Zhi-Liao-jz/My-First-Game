extends Area2D
class_name Bullet
@export var move_component : MoveComponent
@export var damage_mutiple : float
@export var init_speed : float
@onready var speed : float =init_speed:
	set(value):
		speed=value
		move_component.speed=value
var attack_damage : float
var direction : Vector2 :
	set(value):
		direction = value.normalized()
		move_component.direction=direction

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	move_component.speed=speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	pass

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent and area.can_be_damaged:
		var attack = Attack.new()
		attack.attack_damage=attack_damage
		area.damage(attack)
