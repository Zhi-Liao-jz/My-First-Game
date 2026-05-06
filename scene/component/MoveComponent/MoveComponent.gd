extends Node
class_name MoveComponent
@onready var subject : Node2D = get_parent()
var can_move : bool = true
enum move_states{stop,uniform,tween,target,velocity,target_speed}
@export var move_state = move_states.stop :
	set(value) :
		move_state = value
		match value :
			move_states.uniform:
				direction = direction.normalized()
				
var velocity :Vector2 = Vector2.ZERO	#线速度

var direction :Vector2 = Vector2.ZERO :	#初始方向
	set(value):
		direction=value.normalized()
		velocity=direction*speed
@export var speed : float = 0:		#初始速率
	set(value):
		speed=value
		velocity=direction*speed
		
@export var acceleration : float = 0 #加速度
var acceleration_direction : Vector2 = Vector2.ZERO
var target_position : Vector2	#目标位置

signal reach_target

func _physics_process(delta: float) -> void:
	match  move_state:
		move_states.uniform:
			subject.global_position += velocity*delta
		move_states.velocity:
			subject.global_position += velocity*delta
		move_states.target:
			if target_position != Vector2.ZERO:
				acceleration_direction = (target_position - subject.global_position).normalized()
				velocity += acceleration * acceleration_direction * delta
			else:
				acceleration_direction = velocity.normalized()
			subject.global_position += velocity*delta
		move_states.target_speed:
			if subject.global_position != target_position:
				direction = (target_position - subject.global_position).normalized()
				velocity = direction * speed
				if ((subject.global_position + velocity*delta - target_position) * (velocity)) < Vector2.ZERO:
					subject.global_position += velocity*delta
				else:
					subject.global_position = target_position
					reach_target.emit()
