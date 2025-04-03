extends Node
var gravity: float =980.0
var max_health : float =1000.0
var health : float=1000.0
var activation : Array[int] = [0,0,0,0,0,0,0]
var if_erchongshifa : bool = false
var resources : Array[float] = [0,0,0,0,0,0,0]
var max_resources : Array[float] = [1000.0,1000.0,1000.0,1000.0,1000.0,1000.0,1000.0]
var resources_area : Array[int] = [100,100,100,100,100,100,100]
var area_left : float = 80
var area_right : float =1152
var money : int
signal resource_change
signal activation_change
signal money_change
signal area_change
func add_resource (type : int, amount : float):
	resources[type]=min(max_resources[type],resources[type]+amount)
	resource_change.emit(type)
	
func add_money (amount : int):
	money+=amount
	money_change.emit(money)

func change_area(type:int,amount:int):
	resources_area[type]+=amount
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
