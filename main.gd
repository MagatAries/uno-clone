extends Node

#call singleton of deckGenerator function
#var full_deck = DeckGenerator.generate_uno_deck()
@onready var deck_node := $Deck
const Player:= preload("res://player.gd")
#const GameManager := preload("res://game_manager.gd")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_players()
	$Deck.shuffle_deck()
	deal_cards_to_players()
	debug_print_all_hands()
	print("current player hand:",GameManagerSingleton.get_current_player().hand)
	
	GameManagerSingleton.center_card = deck_node.draw_card()
	print("center_card ",GameManagerSingleton.center_card)
	GameManagerSingleton.get_current_player().check_hand(GameManagerSingleton.center_card)
	print("playable cards:",GameManagerSingleton.get_current_player().check_hand(GameManagerSingleton.center_card))
	pass # Replace with function body.

#deal cards 7 per player
func deal_cards_to_players(cards_per_player:int = 7):
	for i in range(cards_per_player):
		for player in GameManagerSingleton.players:
			var card_data = deck_node.draw_card()
			player.receive_card(card_data)
			
			
func debug_print_all_hands():
	for i in range(GameManagerSingleton.players.size()):
		print("Player ", i + 1, " hand:")
		GameManagerSingleton.players[i].print_hand()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setup_players():
	for i in range(4):
		GameManagerSingleton.players.append(Player.new())

func _on_button_pressed() -> void:
	#GameManagerSingleton.get_current_player()
	#var card_data = deck_node.draw_card()
	#print(deck_node.draw_card())
	
	pass # Replace with function body.
