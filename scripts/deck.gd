class_name Deck
extends Node2D

enum Suits {
	HEALTH,
	MONSTER,
	WEAPON,
	SPELL,
}

@export var max_deck_size: int = 52

var default_card = {
	"Suit": "Hearts",
	"Rank": 10,
}
var cards_left = 0
var deck_info = []

@onready var cards_left_label: Label = $CardsLeftLabel


func _ready() -> void:
	generate_new_deck()
	print("-- Deck Debug Info --")
	for card in deck_info:
		print(card)
	print("-- End Deck Debug Info --")


# Updates the internal
func update_deck() -> void:
	cards_left = deck_info.size()
	cards_left_label.text = "Cards Left:\n" + str(cards_left)


func generate_new_deck() -> void:
	for suit in Suits:
		for rank in 13:
			var card = {
				"Suit": suit,
				"Rank": rank + 1,
			}
			deck_info.append(card)
	deck_info.shuffle()
	update_deck()


func get_card():
	var card_info = deck_info.pop_back()

	if card_info == null:
		return null
	else:
		update_deck()
		return card_info


func is_empty():
	return cards_left <= 0
