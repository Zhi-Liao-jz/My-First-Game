extends Node
class_name SkillStateMachine
@export var initial_state:Skill
var current_state : Skill
var states : Dictionary = {}

func _ready():
	for child in get_children():
		if child is Skill:
			states[child.name.to_lower()]=child
			child.Transitioned.connect(on_child_transition)
	if initial_state:
		initial_state.Enter()
		current_state=initial_state

func _process(delta: float):
	if current_state:
		current_state.Update(delta)

func _physics_process(delta: float):
	if current_state:
		current_state.Physics_Update(delta)
		
func _input(event: InputEvent):
	if current_state:
		current_state.input(event)
	
func transition(new_state_name):
	var new_state=states.get(new_state_name.to_lower())
	if !new_state or current_state==new_state:
		return
	if current_state:
		current_state.Exit()
	new_state.Enter()
	current_state=new_state

func on_child_transition(state,new_state_name):
	if state!=current_state && state!=null:
		return
	var new_state=states.get(new_state_name.to_lower())
	if !new_state:
		return
	if current_state:
		current_state.Exit()
	new_state.Enter()
	current_state=new_state
