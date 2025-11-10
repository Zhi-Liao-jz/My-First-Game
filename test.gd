extends PanelContainer
@export var color = Color(1, 0, 0, 1)

func _get_drag_data(position):
	#使用不在树中的控件
	var cpb = ColorPickerButton.new()
	cpb.color = color
	cpb.size = Vector2(50, 50)
	cpb.z_index=100
	set_drag_preview(cpb)
	return color
