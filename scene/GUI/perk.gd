extends TextureRect
class_name Perk
@export var perk_id : Manage.perk_id
@export_multiline var perk_name : String = ""
@export_multiline var perk_description : String = ""
var active : bool = false
@export var number : int
enum perk_state{fllowing,dragging}
var perk_now_state=perk_state.fllowing
var follow_point
@export var active_perk_panel : Control
var stiffness=200
var damping=0.25
var velocity=Vector2.ZERO


func perk_active() -> void:
	Manage.active_perk[perk_id]=1
	pass

func perk_cancel() -> void:
	Manage.active_perk[perk_id]=0
	pass

func _ready() -> void:
	follow_point=get_parent()

func _on_button_button_down() -> void:
	if active:
		follow_point.queue_free()
		follow_point=get_parent()
	perk_now_state=perk_state.dragging


func _on_button_button_up() -> void:
	if active_perk_panel.get_global_rect().has_point(get_global_mouse_position()):
		var perk_follow_point=preload("res://scene/GUI/PerkFollowPoint.tscn").instantiate()
		active_perk_panel.add_child(perk_follow_point)
		follow_point=perk_follow_point
		if active==false:
			active=true
			perk_active()
	else:
		follow_point=get_parent()
		if active:
			active=false
			perk_cancel()
	perk_now_state=perk_state.fllowing


func _on_button_mouse_entered() -> void:
	get_parent().get_parent().show_perk(self)

func _physics_process(delta: float) -> void:
	match perk_now_state:
		perk_state.dragging:
			var target_position=get_global_mouse_position()-size/2
			global_position=global_position.lerp(target_position,0.4)
		perk_state.fllowing:
			if follow_point!=null:
				var target_position=follow_point.global_position
				var deplacement=target_position-global_position
				var force=deplacement*stiffness
				velocity+=force*delta
				velocity*=(1-damping)
				global_position+=velocity*delta
