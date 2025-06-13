extends Node
class_name GameManager

const Player := preload("res://player.gd")


var players :=[]
var current_player_index = 0
var human_player_index = 0
var direction = 1
var center_card:Dictionary = {}
var discard:Array = []
var is_dragging_card :bool= false
var current_card:Dictionary

#how do i know whos turn it is
func get_current_player() -> Player:
	return players[current_player_index]
	
#is it human turn or ai turn
func is_human_turn() -> bool:
	if current_player_index == human_player_index:
		return true
	else:
		return false

func is_reversed() -> bool:
	return false

func discard_center(played_card):
	discard.append(center_card)
	center_card = played_card
	#get_current_player().hand.pop_at()

#how do i move to the next trurn
#input argument of current player, direction, center_card
#what do i do with current player info?
#What do i do with direction? - if direction +1, +1 on current_player_index, if -1, -1 on current_player_index
#if center_card == reverse, change reverse direction (multiply by -1)
#if center_card == skip, current_player_index * (direction)
#if direction +1 amd skip, direction = +2 change index then change back?
#if direction -1 and skip, direction = -2 
func next_turn(deck_node):
	##
	##this will make the current player index +=1
	#initially check center card
	##BUG: noticed +2 going to the current player who PLAYED the +2 card, not sure if skip as well
	if center_card.type == 3: #draw two
		get_current_player().receive_card(deck_node.draw_card())
		get_current_player().receive_card(deck_node.draw_card())
		print("new hand: ",get_current_player().hand)
		skip_turn()
	elif center_card.type == 5: #wild draw 4 and skip
		get_current_player().receive_card(deck_node.draw_card())
		get_current_player().receive_card(deck_node.draw_card())
		get_current_player().receive_card(deck_node.draw_card())
		get_current_player().receive_card(deck_node.draw_card())
		print("draw 4 new hand: ",get_current_player().hand)
		skip_turn()
	elif center_card.type == 2: #REVERSE
		direction *= -1 
		print("REVERSED - direction is now: ",direction)
		
	##check skip first
	elif center_card.type == 1:
		skip_turn()
	
	##handles regular movement after the initial checks of the center card
	if direction == 1:
		current_player_index += 1
	else:
		current_player_index -= 1
	
	current_player_index %= players.size()
	if current_player_index < 0:
		current_player_index += players.size()
	#
	#if current_player_index == 3 and not is_reversed():
		#current_player_index = 0
	#elif current_player_index == 0 and is_reversed():
		#current_player_index = 3
	#elif is_reversed():
		#current_player_index -=1
	#else:
		#current_player_index +=1
		
func skip_turn():
	if direction == 1:
		current_player_index += 2
		return
	elif direction == -1:
		current_player_index -= 2
		return	
