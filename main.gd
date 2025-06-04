extends Node

#call singleton of deckGenerator function
#var full_deck = DeckGenerator.generate_uno_deck()
@onready var deck_node := $Deck
@onready var card_container = $CardContainer
const Player:= preload("res://player.gd")
#const DeckGenerator := preload("res://deck_generator.gd")
#const DeckNode := preload("res://deck.gd")
const CardScene := preload("res://card.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_game()
	
	#play_turn()
	
	#GameManagerSingleton.center_card = deck_node.draw_card()
	#print("center_card ",GameManagerSingleton.center_card)
	#var playable_cards = GameManagerSingleton.get_current_player().check_hand(GameManagerSingleton.center_card)
	#print("playable cards:",playable_cards)
	#if playable_cards:
		#var played_card = GameManagerSingleton.get_current_player().play_card(playable_cards)
		#print("played card: ", played_card)
		##GameManagerSingleton.discard_center(played_card)
		###Testing purposes
		#var test_card = {"color": 2, "type": 3, "value": null}
		#GameManagerSingleton.discard_center(test_card)
		#print("discarded pile size: ", GameManagerSingleton.discard.size(), "discard pile:", GameManagerSingleton.discard)
		#print("new center card: ", GameManagerSingleton.center_card)
	#else:
		#print("No playable cards")
		#GameManagerSingleton.get_current_player().receive_card(deck_node.draw_card())
		#print("current player hand:",GameManagerSingleton.get_current_player().hand)
	#GameManagerSingleton.next_turn(deck_node)
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
	GameManagerSingleton.get_current_player().receive_card(deck_node.draw_card())
	print("current player:", GameManagerSingleton.get_current_player())
	print(GameManagerSingleton.get_current_player().hand)
	GameManagerSingleton.next_turn(deck_node)
	
	print("current player nom:", GameManagerSingleton.get_current_player())
	
	#GameManagerSingleton.get_current_player()
	#var card_data = deck_node.draw_card()
	
	pass # Replace with function body.

func setup_game():
	setup_players()
	$Deck.shuffle_deck()
	deal_cards_to_players()
	
	GameManagerSingleton.center_card = deck_node.draw_card()
	
	var center_card_instance = CardScene.instantiate()
	center_card_instance.set_card_data(GameManagerSingleton.center_card)
	$CardContainer.add_child(center_card_instance)
	center_card_instance.position = Vector2(960, 540)  # move this where your board center is
	
	#var deck_instance = CardScene.instantiate()
	#deck_instance.set_card_data(deck_node)
	#$CardContainer.add_child(deck_instance)
	#deck_instance.position = Vector2(1000,540)
	
	for i in range(deck_node.deck.size()):
		var center_deck = CardScene.instantiate()
		
		center_deck.set_card_data(deck_node.deck[i],true) 
		$CardContainer.add_child(center_deck)
		center_deck.position = Vector2(1200,540)
	#var deck_gen = DECKGENERATOR.new()
	#var cards_data = deck_gen.generate_uno_deck()
	for player in GameManagerSingleton.players: 
		#print(player.hand)
		for j in range(player.hand.size()):
			var is_human = player == GameManagerSingleton.players[0]
			
			var data = player.hand[j]
			var current_hand_instance = CardScene.instantiate()
			current_hand_instance.set_card_data(data, not is_human)  # this sets the image, color, etc
			##print(card_instance)
			#add_child(current_hand_scene)  # put it in the scene
			card_container.add_child(current_hand_instance)
			print(player)
			if player == GameManagerSingleton.players[0]:
				current_hand_instance.position = Vector2((150 * j) + 500, 1000)  # space them out horizontally
			elif player == GameManagerSingleton.players[2]:
				current_hand_instance.position = Vector2((150 * j) + 500, 100)  # space them out horizontally
			elif player == GameManagerSingleton.players[1]:
				current_hand_instance.position = Vector2(1830,(150 * j) + 100)  # space them out vertically
			elif player == GameManagerSingleton.players[3]:
				current_hand_instance.position = Vector2(100,(150 * j) + 100)  # space them out vertically
			
	#debug_print_all_hands()
func play_turn():
	#var current = GameManagerSingleton.get_current_player()
	#if GameManagerSingleton.is_human_turn():
		## Wait for input (button click, drag/drop)
		#return
	#else:
		#current.take_turn(deck_node, GameManagerSingleton.center_card)
		#GameManagerSingleton.next_turn()
		## Optional: add delay or call this again via a timer
		#play_turn()
		
		
	var current_player = GameManagerSingleton.get_current_player()
	if GameManagerSingleton.is_human_turn():
		return
	else:
		#print("current player hand:",GameManagerSingleton.get_current_player().hand)
		#print("center_card ",GameManagerSingleton.center_card)
		current_player.take_turn(deck_node,GameManagerSingleton.center_card)
		GameManagerSingleton.next_turn(deck_node)
