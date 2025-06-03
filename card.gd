extends Node2D

var card_data:Dictionary

const deckGen := preload("res://deck_generator.gd")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_card_data(data:Dictionary):
	var card_name = get_card_texture_name(data)
	var texture_path = "res://assets/cards/%s.png" % card_name
	print(texture_path)
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
