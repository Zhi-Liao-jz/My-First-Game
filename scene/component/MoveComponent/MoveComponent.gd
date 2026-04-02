extends Node
class_name MoveComponent
@onready var subject : Node2D = get_parent()
var can_move : bool = true
enum move_states{stop,uniform,tween,target,velocity}
var move_state = move_states.stop :
	set(value) :
		move_state = value
		match value :
			move_states.uniform:
				direction = direction.normalized()
				
var velocity :Vector2 = Vector2.ZERO	#线速度

var direction :Vector2 = Vector2.ZERO :	#初始方向
	set(value):
		direction=value
		velocity=direction*speed
@export var speed : float = 0:		#初始速率
	set(value):
		speed=value
		velocity=direction*speed

var target_position : Vector2	#目标位置

func _physics_process(delta: float) -> void:
	match  move_state:
		move_states.uniform:
			subject.position+=velocity*delta
		move_states.velocity:
			subject.position+=velocity*delta
