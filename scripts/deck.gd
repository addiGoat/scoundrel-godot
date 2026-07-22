class_name Deck
extends Node2D

enum Suits {
	POTION,
	MONSTER,
	WEAPON,
	SPELL,
}

@export var weapons_amount: int = 9
@export var potions_amount: int = 9
@export var monsters_amount: int = 26
@export var spells_amount: int = 9

var default_card = {
	"Suit": "Hearts",
	"Rank": 10,
}
var cards_left = 0
var deck_info = []

@onready var cards_left_label: Label = $CardsLeftLabel


func _ready() -> void:
	generate_new_deck()


func update_deck() -> void:
	cards_left = deck_info.size()
	cards_left_label.text = "Cards Left:\n" + str(cards_left)


func generate_suit(suit) -> void:
	var amount: int

	match suit:
		"POTION":
			amount = potions_amount
		"MONSTER":
			amount = monsters_amount
		"WEAPON":
			amount = weapons_amount
		"SPELL":
			amount = spells_amount
	for i in amount:
		var rank: int
		if suit != "MONSTER":
			rank = randi_range(2, 10)
		else:
			rank = randi_range(2, 14)
		var card = {
			"Suit": suit,
			"Rank": rank,
		}
		deck_info.append(card)


func generate_new_deck() -> void:
	for suit in Suits:
		generate_suit(suit)
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


func print_deck_info() -> void:
	print("-- Deck Debug Info --")
	for card in deck_info:
		print(card)
	print("-- End Deck Debug Info --")
