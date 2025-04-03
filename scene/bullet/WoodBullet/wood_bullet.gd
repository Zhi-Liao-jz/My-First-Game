extends Area2D
@export var damage_mutiple =1
@export var speed = 100.0
@export var ray_cast : RayCast2D
var life_time : float = 30.0
var attack_damage : float
var direction : Vector2
var velocity : Vector2
var target : Enemy

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	direction=Vector2(randf(),randf())
	velocity=direction.normalized()*speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation=velocity.angle()
	life_time-=delta
	if life_time<=0:
		queue_free()
	
func _physics_process(delta: float) -> void:
	if target:
		direction=target.position-position
		velocity+=direction.normalized()*speed*delta
	position+=velocity*delta
	ray_cast.target_position=ray_cast.target_position.rotated(PI*delta)
	if ray_cast.get_collider():
		var collition=ray_cast.get_collider().get_parent()
		if target:
			if (target.position-position).length()>(collition.position-position).length():
				target=collition
		else:
			target=collition

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		var attack = Attack.new()
		attack.attack_damage=attack_damage
		area.damage(attack)
