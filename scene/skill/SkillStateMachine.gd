extends Node
class_name SkillStateMachine
@export var initial_state : Skill
@export var skill_icon : Sprite2D
@export var skill_name_label : Label
@export var skill_description_label : Label
@export var perk_menu : Panel
@export var perk_wuzhongshengyou : Perk
var current_state : Skill
var states : Dictionary = {}

func _ready():
	for child in get_children():
		if child is Skill:
			states[child.name.to_lower()]=child
			child.spawn_bullet.connect(perk_wuzhongshengyou.wuzhongshengyou)
	if initial_state:
		initial_state.Enter()
		current_state=initial_state

func _process(delta: float):
	if current_state and not get_tree().paused:
		current_state.Update(delta)

func _physics_process(delta: float):
	if current_state and not get_tree().paused:
		current_state.Physics_Update(delta)
		
func _input(event: InputEvent):
	if current_state and not get_tree().paused:
		current_state.input(event)
	
func transition(new_state_name):
	var new_state=states.get(new_state_name.to_lower())
	if !new_state or current_state==new_state:
		return
	if current_state:
		current_state.Exit()
	new_state.Enter()
	if new_state.icon:
		skill_icon.texture=new_state.icon
	skill_name_label.text=SkillMap.skill_name[new_state_name]
	skill_description_label.text=SkillMap.skill_description[new_state_name]
	perk_menu.transition(new_state_name)
	current_state=new_state
