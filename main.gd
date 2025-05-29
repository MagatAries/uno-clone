extends Node

#call singleton of deckGenerator function
#var full_deck = DeckGenerator.generate_uno_deck()
@onready var deck_node := $Deck

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var first_card = deck_node.draw_card()
	print("first card:",first_card)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	print(deck_node.draw_card())
	pass # Replace with function body.
