class_name Deck
extends Node2D

var defaut_card = {
	"Suit": "Hearts",
	"Rank": 10,
}
var cards_left = 0
var suits = ["Hearts", "Diamonds", "Clubs", "Spades"]
var deck_info = []

@onready var cards_left_label: Label = $CardsLeftLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_new_deck()
	print("-- Deck Debug Info --")
	for card in deck_info:
		print(card)
	print("-- End Deck Debug Info --")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func generate_new_deck() -> void:
	for suit in suits:
		for rank in 2:
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


func update_deck() -> void:
	cards_left = deck_info.size()
	update_display()


func update_display() -> void:
	cards_left_label.text = "Cards Left:\n" + str(cards_left)
