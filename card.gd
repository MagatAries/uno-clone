extends Node2D

var card_data:Dictionary
var is_hovered = false
var is_dragging = false
var drag_offset = Vector2.ZERO
var hover_offset = Vector2.ZERO
const deckGen := preload("res://deck_generator.gd")
const player := preload("res://player.gd")
var belongs_to_player := false
var original_position = Vector2.ZERO
var base_hover_position = Vector2.ZERO
var current_card:Dictionary
#var original_y := 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Area2D.mouse_entered.connect(_on_area_2d_mouse_entered)
	$Area2D.mouse_exited.connect(_on_area_2d_mouse_exited)
	$Area2D.input_event.connect(_on_area_2d_input_event)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if is_dragging:
		is_hovered = false
		position = get_global_mouse_position() + drag_offset
	pass

func set_card_data(data:Dictionary, show_back:= false):
	card_data = data
	if data:
		var card_name = get_card_texture_name(data)
		var texture_path = "res://assets/cards/%s.png" % card_name
		if show_back:
			$CardSprite.texture = load("res://assets/misc/Deck.png")
		#print(texture_path)
		else:
			$CardSprite.texture = load(texture_path)
	
func get_card_texture_name(data:Dictionary) -> String:
	var card_name:String
	var card_color:String
	var card_type:String
	var card_value:String
	
	##Check if wild first:
	if data.type == 4:
		card_type = "WILD"
		return card_type
	elif data.type == 5:
		card_type = "Wild_Draw"
		return card_type
		
	#enum CardColor { RED, BLUE, GREEN, YELLOW, WILD}
	if data.color == 0:
		card_color = "RED"
	elif data.color == 1:
		card_color = "BLUE"
	elif data.color == 2:
		card_color = "GREEN"
	elif data.color == 3:
		card_color = "YELLOW"
	elif data.color == 4:
		card_color = "WILD"
		return card_color
	
	#enum CardType { NUMBER, SKIP, REVERSE, DRAW_TWO, WILD, WILD_DRAW_FOUR }
	if data.type == 1:
		card_type = "SKIP"
		return card_color + "_" + card_type
	elif data.type == 2:
		card_type = "REVERSE"
		return card_color + "_" + card_type
	elif data.type == 3:
		card_type = "DRAW"
		return card_color + "_" + card_type
	
	if data.value == 0:
		card_value = "0"
	elif data.value == 1:
		card_value = "1"
	elif data.value == 2:
		card_value = "2"
	elif data.value == 3:
		card_value = "3"
	elif data.value == 4:
		card_value = "4"
	elif data.value == 5:
		card_value = "5"
	elif data.value == 6:
		card_value = "6"
	elif data.value == 7:
		card_value = "7"
	elif data.value == 8:
		card_value = "8"
	elif data.value == 9:
		card_value = "9"
	
	card_name = card_color + "_" + card_value
	return card_name


func _on_area_2d_mouse_entered() -> void:
	if not belongs_to_player or GameManagerSingleton.is_dragging_card or is_hovered:
		return
	base_hover_position = position
	original_position = position
	position = base_hover_position - Vector2(0, 20)
	is_hovered = true


func _on_area_2d_mouse_exited() -> void:
	if not belongs_to_player or GameManagerSingleton.is_dragging_card or not is_hovered:
		return
	position = base_hover_position
	is_hovered = false
	
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	var playable_cards = GameManagerSingleton.get_current_player().check_hand(GameManagerSingleton.center_card)
	var card_holding:Dictionary
	if not belongs_to_player:
		return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			GameManagerSingleton.is_dragging_card = true
			is_dragging = true
			drag_offset = position - get_global_mouse_position()
			print("card: ", card_data)
		elif event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			GameManagerSingleton.is_dragging_card = false
			is_dragging = false
			var drop_zone = get_tree().get_root().get_node("Main/DropZone")
			var collision_shape = drop_zone.get_node("CollisionShape2D")
			var shape := collision_shape.shape as RectangleShape2D
			var extents = shape.extents
			#if drop_zone and drop_zone.is_position_inside(global_position):
			if collision_shape and collision_shape.shape is RectangleShape2D:
				var transform: Transform2D = collision_shape.get_global_transform()
				#draw_set_transform(transform.origin, transform.get_rotation(), transform.get_scale())
				var rect = Rect2(transform.origin - extents, extents * 2)
				print("shape rectangle",rect)
				if playable_cards:
					#GameManagerSingleton.get_current_player().play_card(card_data)
					print("playable:",GameManagerSingleton.get_current_player().check_hand(GameManagerSingleton.center_card))
					if rect.has_point(global_position):
						print("play card", card_data)
						GameManagerSingleton.get_current_player().take_turn_from_input(deckGen, card_data)
					else:
						position = base_hover_position
						print("did not play card")
				#else:
					#position = base_hover_position
					#print("did not play card")
			else:
				position = base_hover_position 
			#manually check if its in playable area
