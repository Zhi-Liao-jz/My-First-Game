extends Node
@export var resources : Array[Control]

func _ready():
	Manage.area_change.connect(update_area)

func update_area():
	for i in range(5):
		resources[i].size_flags_stretch_ratio=Manage.resources_area[i]
		pass
	pass
