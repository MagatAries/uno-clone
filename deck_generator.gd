extends Node

#create enums of Card Color and Card Type
enum CardColor { RED, BLUE, GREEN, YELLOW, WILD}
enum CardType { NUMBER, SKIP, REVERSE, DRAW_TWO, WILD, WILD_DRAW_FOUR }

#generating an uno deck 
func generate_uno_deck() -> Array:
	#empty deck array
	var deck := []
	var colors := [CardColor.RED, CardColor.BLUE, CardColor.GREEN, CardColor.YELLOW]
	
	# 1x ZERO per color
	for color in colors:
		deck.append({
			"color":color,
			"type":CardType.NUMBER,
			"value": 0
		})
	
	# 2x EACH of 1-9, skip, reverse, draw 2 per color
	for color in colors:
		#1-9
		for value in range(1,10):
			for i in range(2):
				deck.append({
					"color":color,
					"type":CardType.NUMBER,
					"value": value
				})
		#skip, reverse, draw 2
		for special_type in [CardType.SKIP,CardType.REVERSE,CardType.DRAW_TWO]:
			for i in range(2):
				deck.append({
					"color": color,
					"type": special_type,
					"value": null
				})
				
	# 4x wild and wild draw 4
	for i in range(4):
		deck.append({
			"color": CardColor.WILD,
			"type": CardType.WILD,
			"value": null
		})
		deck.append({
			"color": CardColor.WILD,
			"type": CardType.WILD_DRAW_FOUR,
			"value": null
		})
	return deck


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
