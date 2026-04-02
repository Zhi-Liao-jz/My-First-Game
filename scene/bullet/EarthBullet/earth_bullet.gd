extends Bullet
var size : float = 10
@export var g : float = 490
@export var lerp : float = 0.005
@export var trail_point_number = 5
@export var trail : Line2D

var velocity : Vector2 :
	set(value):
		velocity=value
		move_component.velocity=velocity

func _ready() -> void:
	move_component.can_move=true
	move_component.move_state=MoveComponent.move_states.velocity

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	velocity+=delta*Vector2(0,g)
	velocity*=(1-lerp)
	trail.global_position=Vector2(0,0);
	trail.add_point(global_position)
	if trail.get_point_count()>trail_point_number:
		trail.remove_point(0)
	queue_redraw()
	
func _draw() -> void:
	draw_circle(Vector2(0,0),size,Color("99661aff"))
	
func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent and area.can_be_damaged:
		var attack = Attack.new()
		attack.attack_damage=attack_damage
		area.damage(attack)
		queue_free()
		
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
