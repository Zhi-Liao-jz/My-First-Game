extends Bullet
@export var yinbaoshijian : float
@export var chixushijian : float
@export var panding : CollisionShape2D
@export var donghua : Node2D
@export var one : Sprite2D
var process : float = 0
@export var shanghaijiange : float
var shanghaiprocess : float = 0
var zhuangtai : int =0
var tween : Tween

func _ready() -> void:
	super()
	
func _process(delta: float) -> void:
	process+=delta
	if zhuangtai == 0:
		one.rotate(delta*PI*8)
		position+=Vector2(0,-50)*delta
		one.scale=Vector2(1,1)*(1+sin(process*50)/20)
		if process > yinbaoshijian:
			yinbao()
			zhuangtai = 1
			process=0
	elif zhuangtai == 1:
		if process > chixushijian:
			xiaosan()
			zhuangtai=2
			process=0
	else:
		if process>0.3:
			queue_free()
		
func _physics_process(delta: float) -> void:
	if zhuangtai == 1:
		shanghaiprocess+=delta
		if panding.disabled:
			panding.set_deferred("disabled",false)
		elif shanghaiprocess>shanghaijiange:
			shanghaiprocess=0
			panding.set_deferred("disabled",true)
			
func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent and area.can_be_damaged:
		var attack = Attack.new()
		attack.gaowen=true
		attack.attack_damage=attack_damage
		area.damage(attack)

func yinbao() ->void:
	donghua.visible=true
	one.visible=false

func xiaosan() ->void:
	if tween:
		tween.kill()
	tween=create_tween()
	tween.tween_property(donghua,"modulate",Color(1,1,1,0),0.3)
	
