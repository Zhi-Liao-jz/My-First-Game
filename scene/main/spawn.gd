extends Node
@export var raid_point : float
@export var maoyu_scene : PackedScene
var spawn_point : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_point=0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spawn_point+=raid_point*delta
	if spawn_point>100:
		var maoyu = maoyu_scene.instantiate()
		var maoyu_spawn_location = $Path/SpawnLocation
		maoyu_spawn_location.progress_ratio = randf()
		maoyu.position=maoyu_spawn_location.position
		add_child(maoyu)
		spawn_point-=100
