extends Node
class_name GameManager

const Player := preload("res://player.gd")
var players :=[]
var current_player_index = 0
var human_player_index = 0
var direction = 1
var center_card:Dictionary = {}
var discard:Array = []

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

#how do i move to the next trurn
func next_turn():
	##
	##this will make the current player index +=1
	#current_player_index += 1
	if current_player_index == 3 and not is_reversed():
		current_player_index = 0
	elif current_player_index == 0 and is_reversed():
		current_player_index = 3
	elif is_reversed():
		current_player_index -=1
	else:
		current_player_index +=1

 
	
