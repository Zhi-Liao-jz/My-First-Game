extends Bullet
var chixushijian : float
var xuanzhuansudu : float
@export var tupian : Sprite2D
@export var fazhen : Sprite2D
@export var panding : CollisionShape2D
@export var guangzhu : Array[Sprite2D]
@export var shanghaijiange : float
var process : float = 0.0

func _ready() -> void:
	super()
	chixushijian=0
	
func _process(delta: float) -> void:
	#旋转动画
	chixushijian+=delta
	xuanzhuansudu+=delta/2
	tupian.rotate(xuanzhuansudu*delta)
	var tupian_roration=tupian.rotation
	var cnt=0
	for i in guangzhu:
		var guangzhu_roration=tupian_roration+cnt*PI/3
		var position1 = fazhen.position + Vector2(fazhen.get_rect().size.x/3,0).rotated(guangzhu_roration)*fazhen.scale
		i.position=position1
		i.position.y-=32*i.scale.y
		cnt+=1

func _physics_process(delta: float) -> void:
	#伤害间隔
	process+=delta
	if panding.disabled:
		panding.set_deferred("disabled",false)
	else:
		if process > shanghaijiange:
			process=0
			panding.set_deferred("disabled",true)

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent and area.can_be_damaged:
		var attack = Attack.new()
		if chixushijian>5:
			attack.attack_damage=attack_damage*2
		else:
			attack.attack_damage=attack_damage*(1+chixushijian/5)
		area.damage(attack)
			
