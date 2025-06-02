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
	var playable_cards = GameManagerSingleton.get_current_player().check_hand(GameManagerSingleton.center_card)
	print("playable cards:",playable_cards)
	if playable_cards:
		var played_card = GameManagerSingleton.get_current_player().play_card(playable_cards)
		print("played card: ", played_card)
		#GameManagerSingleton.discard_center(played_card)
		##Testing purposes
		var test_card = {"color": 2, "type": 3, "value": null}
		GameManagerSingleton.discard_center(test_card)
		print("discarded pile size: ", GameManagerSingleton.discard.size(), "discard pile:", GameManagerSingleton.discard)
		print("new center card: ", GameManagerSingleton.center_card)
	else:
		print("No playable cards")
		GameManagerSingleton.get_current_player().receive_card(deck_node.draw_card())
		print("current player hand:",GameManagerSingleton.get_current_player().hand)
	GameManagerSingleton.next_turn(deck_node)
	#next turn 
	#next turn requires getcurrentplayer 
	#depending on center_card, change 
	

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
