extends Perk

func perk_active() -> void:
	Manage.active_perk[perk_id]=1
	Manage.change_area(0,1000)
	print(3)
	pass

func perk_cancel() -> void:
	Manage.active_perk[perk_id]=0
	Manage.change_area(0,-1000)
	print(4)
	pass
