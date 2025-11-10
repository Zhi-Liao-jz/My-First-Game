extends Panel
@export var initial_state:Control
@export var perk_name : Label
@export var perk_description : Label
var current_state : Control
var states : Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()]=child
	if initial_state:
		current_state=initial_state
		current_state.visible=true

func transition(new_state_name):
	var new_state=states.get(new_state_name.to_lower())
	if not new_state:
		return
	current_state.visible=false
	new_state.visible=true
	current_state=new_state
	
func show_perk(perk : Perk) -> void:
	perk_name.text = perk.perk_name
	perk_description.text = perk.perk_description
