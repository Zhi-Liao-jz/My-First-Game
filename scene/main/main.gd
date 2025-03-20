extends Node
@export var chong_neng : Array[ColorRect]
var resources : Array[float] = [0,0,0,0,0,0,0]
var max_resources : Array[float] = [1000.0,1000.0,1000.0,1000.0,1000.0,1000.0,1000.0]
@export var xuan_zhong : Array[ReferenceRect]
@export var skill_state_machine : SkillStateMachine
@export var money_label : Label
var fake_money : int = 0 : set = _on_fake_money_set
var tween : Tween
# Called when the node enters the scene tree for the first time.
func _ready():
	Manage.resource_change.connect(update_resources)
	Manage.activation_change.connect(update_xuan_zhong)
	Manage.money_change.connect(update_money)

func update_xuan_zhong (key : int,vis:int) :
		xuan_zhong[key].visible=vis
		var skill_number : int = 0
		skill_number = Manage.activation[0]*64 + Manage.activation[1]*32 + Manage.activation[2]*16 + Manage.activation[3]*8 + Manage.activation[4]*4 + Manage.activation[5]*2 + Manage.activation[6]
		if SkillMap.skill.has(skill_number):
			skill_state_machine.transition(SkillMap.skill.get(skill_number))
		else:
			skill_state_machine.transition("noskill")

func update_resources(type : int) -> void:
	chong_neng[type].scale.y = 1-(Manage.resources[type]/Manage.max_resources[type])
	
func update_money(money : int) -> void:
	if tween :
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self,"fake_money",money,2.0)
func _on_fake_money_set(new_value : int) ->void:
	fake_money=new_value
	money_label.text=str(fake_money)
