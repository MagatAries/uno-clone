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
		var is_playable = false
		
		if card.color == center_card.color:
			is_playable = true
		if card.value != null and card.value == center_card.value:
			is_playable = true
		if card.type == center_card.type and card.type != 0:
			is_playable = true

		if is_playable:
			playable_cards.append(card)
		#var is_playable = false
		#if card.value != center_card.value:
			#is_playable = false
			#if card.color == center_card.color:
				#is_playable = true
		#else:
			#
		#if card.type != center_card.type:
			#is_playable = false
			#if card.color == center_card.color:
				#is_playable = true
		#if card.color == center_card.color or card.value == center_card.value or card.type == center_card.type:
		#	is_playable = true
		
		#if card.color == center_card.color:
			#print("color")
			#is_playable = true
		#if card.value == center_card.value:
			#if card.value != null:
				#print("value")
				#is_playable = true
		########################################
		#if card.type == center_card.type:
			#if center_card.type != 0: ##if cardtype is a number we dont want to be able to play any number unless card is same color
				#is_playable = true
			##else:
				##is_playable = false
		########################################
	return playable_cards

func play_card(playable_cards:Array) -> Dictionary:
	var random_index = randi() % playable_cards.size()
	return playable_cards[random_index]
	
