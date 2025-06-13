extends Area2D


func is_position_inside(pos: Vector2):
	print("$CollisionShape2D.shape is Shape2D: ",$CollisionShape2D.shape is Shape2D)
	$CollisionShape2D.shape
	print("$CollisionShape2D.shape.collide_point(to_local(pos): ",$CollisionShape2D.shape.collide_point(to_local(pos)))
	return $CollisionShape2D.shape is Shape2D and $CollisionShape2D.shape.collide_point(to_local(pos))
	pass
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _draw():
	var shape = $CollisionShape2D.shape as RectangleShape2D
	if not shape:
		return
	
	if Engine.is_editor_hint():
		return
	var extents = shape.extents
	var transform: Transform2D = $CollisionShape2D.transform
	draw_set_transform(transform.origin, transform.get_rotation(), transform.get_scale())
	draw_rect(Rect2(global_position - extents, extents * 2), Color (0,1,0,0.2), true)
	#draw_rect(Rect2(global_position-extents,extents * 2), Color (1,0,0,0.2), true)
	draw_set_transform(Vector2.ZERO, 0, Vector2.ONE)
