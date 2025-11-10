extends Perk
var total_add_resource : Array[float] = [0,0,0,0,0,0,0]

func wuzhongshengyou(amount : int) -> void:
	if active:
		var type : int = (randf()*1000)
		type%=7
		Manage.add_resource(type,amount)
