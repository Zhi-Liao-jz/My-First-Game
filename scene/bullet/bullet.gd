extends Area2D
class_name Bullet
@export var damage_mutiple : float
@export var speed : float
var attack_damage : float
var direction : Vector2
var velocity : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity=direction.normalized()*speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity=direction.normalized()*speed
	
func _physics_process(delta: float) -> void:
	position+=velocity*delta

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent and area.can_be_damaged:
		var attack = Attack.new()
		attack.attack_damage=attack_damage
		area.damage(attack)
