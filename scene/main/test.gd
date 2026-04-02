extends Node
@export var az : PackedScene

func _ready() -> void:
	var curve = Curve2D.new().duplicate()
	curve.add_point(Vector2(100,100))
	curve.add_point(Vector2(200,200))
	curve.add_point(Vector2(300,100))
	curve.add_point(Vector2(400,200))
	pass
