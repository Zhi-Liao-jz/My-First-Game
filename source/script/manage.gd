extends Node
var gravity: float =980.0
var max_health : float =1000.0
var health : float=1000.0
var activation : Array[int] = [0,0,0,0,0,0,0]
var if_erchongshifa : bool = false
var resources : Array[float] = [1000,0,0,0,0,0,0]
var max_resources : Array[float] = [1000.0,1000.0,1000.0,1000.0,1000.0,1000.0,1000.0]
var resources_area : Array[float] = [100,100,100,100,100]

enum perk_id{double_use,water_3,fire_xiajibashe,fire_only,fire_bomb,wuzhongshengyou,esc}
var active_perk = {
	perk_id.double_use:0,
	perk_id.water_3:0,
	perk_id.fire_xiajibashe:0,
	perk_id.fire_only:0,
	perk_id.fire_bomb:0,
	perk_id.wuzhongshengyou:0,
	perk_id.esc:0
}

var resources_area_sum : float = 500
var area_left : float = 95
var area_right : float =1152
var money : int
signal resource_change
signal activation_change
signal money_change
signal area_change
func _init() -> void:
	process_mode=Node.PROCESS_MODE_ALWAYS

func add_resource (type : int, amount : float):
	resources[type]=min(max_resources[type],resources[type]+amount)
	resource_change.emit(type)
func add_money (amount : int):
	money+=amount
	money_change.emit(money)

func change_area(type:int,amount:int):
	resources_area[type]+=amount
	resources_area_sum = 0
	for i in resources_area:
		resources_area_sum+=i
	area_change.emit()
	
func _input(event: InputEvent):
	if event is InputEventKey and event.is_pressed():
		var key:int = -1
		if event.keycode==KEY_1:
			key=0
		elif event.keycode==KEY_2:
			key=1
		elif event.keycode==KEY_3:
			key=2
		elif event.keycode==KEY_4:
			key=3
		elif event.keycode==KEY_5:
			key=4
		elif event.keycode==KEY_6:
			key=5
		elif event.keycode==KEY_7:
			key=6
		if event.keycode==KEY_SPACE or (key!=-1 and if_erchongshifa==false):
			for i in range(7):
				if i == key:
					continue
				activation[i]=0
				activation_change.emit(i,activation[i])
		if key!=-1:
			activation[key]^=1
			activation_change.emit(key,activation[key])
