extends Node
class_name Player

var hand:Array = []

func receive_card(card_data:Dictionary) -> void:
	hand.append(card_data)
	
func print_hand():
	for card in hand:
		print(card)

func check_hand(center_card)->Array:
	var playable_cards = []
	for card in hand:
		if is_card_playable(card, center_card):
			playable_cards.append(card)
	return playable_cards
	
##NOT FINAL
func play_card(playable_cards:Array) -> Dictionary:
	var random_index = randi() % playable_cards.size()
	return playable_cards[random_index]
	
##NOT FINAL
#take turn for ai
func take_turn(deck_node, center_card):
	if not GameManagerSingleton.is_human_turn():
		var playable_cards = check_hand(center_card)
		print("playable cards:",playable_cards)
		print("Color after change333:", GameManagerSingleton.center_card.color)
		if playable_cards:
			var played_card = play_card(playable_cards)
			print("played card: ", played_card)
			hand.erase(played_card) 
			if played_card.color == 4 or played_card.type == 4 or played_card.type == 5:
				print("ask user for what color:", GameManagerSingleton.center_card.color)
				GameManagerSingleton.center_card.color = 0
				print("Color after change:", GameManagerSingleton.center_card.color)			
			#discard_center(played_card)
			##Testing purposes
			#var test_card = {"color": 2, "type": 3, "value": null}
			GameManagerSingleton.discard_center(played_card)
			print("discarded pile size: ", GameManagerSingleton.discard.size(), "discard pile:", GameManagerSingleton.discard)
			print("new center card: ", center_card)
		else:
			print("No playable cards")
			receive_card(deck_node.draw_card())
			print("current player hand:",hand)
	pass
	
#take turn for player
func take_turn_from_input(deck_node, card_data: Dictionary):
	if GameManagerSingleton.get_current_player() != self:
		print("Not your turn.") ##Message or UI implementation after to prevent user from playing out of turn
		return false
	if not is_card_playable(card_data, GameManagerSingleton.center_card):
		print("Card is not playable") ##Message or UI implememtation after to show card is not playable
		return false
		
	hand.erase(card_data)
	GameManagerSingleton.discard_center(card_data)
	#GameManagerSingleton.center_card = card_data
	
	if card_data.color == 4 or card_data.type == 4 or card_data.type == 5:
		GameManagerSingleton.center_card.color = 0 #placeholder ##TEST
		print("player must choose a color: (NOT YET IMPLEMENTED)")
		
	print("Card Played: ",card_data)
	return true
		
func is_card_playable(card: Dictionary, center_card: Dictionary) -> bool:
	if card.color == center_card.color:
		return true
	if card.value != null and card.value == center_card.value:
		return true
	if card.type == center_card.type and card.type != 0:
		return true
	if card.type == 4 or card.type == 5: #wild card
		return true
	return false
