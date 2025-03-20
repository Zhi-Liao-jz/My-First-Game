extends Area2D
@export var damage_mutiple =1.0
@export var speed = 200.0
@export var fire_strength = 100.0
@export var hit_box : CollisionShape2D
var fire_strength_decrease_time = 0.08
var fire_strength_decrease_hit = 1.0
var attack_damage : float
var direction : Vector2
var velocity : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = speed*(0.5+randf())
	fire_strength = fire_strength * (0.7+0.6*randf())
	velocity=direction.normalized()*speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	fire_strength -= speed*delta*fire_strength_decrease_time*fire_strength_decrease_hit
	fire_strength_decrease_hit=max(fire_strength_decrease_hit-delta*10,1)
	if fire_strength<20:
		queue_free()
	velocity=direction.normalized()*speed*fire_strength/100.0
	position+=velocity*delta
	scale.x=fire_strength/50.0
	scale.y=fire_strength/50.0

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		var attack = Attack.new()
		attack.attack_damage=attack_damage*fire_strength/100.0
		area.damage(attack)
		fire_strength_decrease_hit+=5


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
