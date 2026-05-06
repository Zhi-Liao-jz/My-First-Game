extends Skill
var cold : float = 2
var use=5.0
var process : float = 0.0
@export var amount : int = 8

func Enter():
	pass
	
func Exit():
	pass

func input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if process==0:
			for i in range(amount):
				var bullet=bullet_scene.instantiate()
				$CanvasGroup.add_child(bullet)
				bullet.position=Vector2(10,0)*randf()+Vector2(0,10)*randf()
				bullet.direction=(event.position-global_position).rotated(randf()*PI/4-PI/8).normalized()
				bullet.speed=400+randf()*200
				process=cold

func Update(delta : float):
	if process>0:
		process=max(0.0,process-delta)
