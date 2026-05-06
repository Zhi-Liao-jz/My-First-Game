extends Node

var bullet_list : Dictionary ={
	"fire":preload("res://scene/bullet/FireBullet/FireBullet.tscn")
}

func spawn(bullet_name:String,spawn_position:Vector2,rotation:float,direction:Vector2):
	var bullet : Bullet = bullet_list[bullet_name].instantiate()
	bullet.global_position=spawn_position
	bullet.rotation=rotation
	bullet.move_component.direction=direction
	
