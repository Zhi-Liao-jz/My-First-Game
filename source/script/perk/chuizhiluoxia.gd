extends Perk

func perk_active() -> void:
	Manage.active_perk[perk_id]=1

func perk_cancel() -> void:
	Manage.active_perk[perk_id]=0
