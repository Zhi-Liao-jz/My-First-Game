extends Node
@export var shop_panel : Panel

func _on_商店按钮_pressed() -> void:
	if get_tree().paused:
		get_tree().paused=false
		shop_panel.visible=false
	else:
		get_tree().paused=true
		shop_panel.visible=true
	
