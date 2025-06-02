extends Node

#call singleton of deckGenerator function
#var full_deck = DeckGenerator.generate_uno_deck()
var deck := []

#load deck generation
const deckGen := preload("res://deck_generator.gd")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	deck = DeckGenerator.generate_uno_deck()
	shuffle_deck()
	
func draw_card() -> Dictionary:
	if deck.size() > 0:
		return deck.pop_front()
	else:
		print("Deck is empty!")
		return {} #return null or empty dictionary -> returns dictionary  
		

func shuffle_deck():
	deck.shuffle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
