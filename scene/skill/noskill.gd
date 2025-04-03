extends Skill
@export var xuan_zhong : Array[ReferenceRect]
func Enter():
	for i in range(7):
		xuan_zhong[i].border_color=Color(1,0,0,1)
func Exit():
	for i in range(7):
		xuan_zhong[i].border_color=Color(0.05,0.82,0.27,7)
