extends Node
@export var shop_panel : Panel

func _input(event: InputEvent):
	if event is InputEventKey and event.is_pressed() and event.keycode==KEY_ESCAPE and Manage.active_perk[Manage.perk_id.esc]:
		_on_商店按钮_pressed()

func _on_商店按钮_pressed() -> void:
	if get_tree().paused:
		get_tree().paused=false
		shop_panel.visible=false
	else:
		get_tree().paused=true
		shop_panel.visible=true
	
