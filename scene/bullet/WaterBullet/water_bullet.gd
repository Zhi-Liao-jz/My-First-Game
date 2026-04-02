extends Area2D
var attack_damage : float
@export var damage_mutiple : float
@export var speed = 400.0
var direction : Vector2 :
	set(value):
		direction=value.normalized()
var velocity : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	position+=speed*direction*delta

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent and area.can_be_damaged:
		var attack = Attack.new()
		attack.attack_damage=attack_damage
		attack.force=1
		area.damage(attack)
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
