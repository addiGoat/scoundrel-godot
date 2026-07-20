extends Node2D

const CARD_SCENE = preload("res://scenes/card.tscn")

var room_size: int = 4
var current_drawn_cards = 0

@onready var deck: Deck = $Deck
@onready var room: Node2D = $Room
@onready var card_spawns = room.find_children("CardSpawn?")
@onready var marker: Marker2D = $Room/CardSpawn1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# draw_new_card()
	fill_room_to_max()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func update_room() -> void:
	current_drawn_cards = 0
	for c in room.get_children():
		if c is Card:
			current_drawn_cards = current_drawn_cards + 1

	print(current_drawn_cards)


func add_card_to_room(card: Card, spawn) -> void:
	if card == null:
		return
	card.slot = spawn
	spawn.place_card(card)
	room.add_child(card)
	update_room()


func draw_new_card() -> Card:
	var card_data = deck.get_card()
	if card_data == null:
		print("[game] - No cards remaining")
		return null

	var card: Card = CARD_SCENE.instantiate()
	card.set_card_data(card_data)
	card.selected.connect(_on_card_selected)
	print("[game] - Drawn card: ", card)
	return card


func fill_room_to_max() -> void:
	for spawn in card_spawns:
		if spawn.is_empty():
			print(spawn, " is empty.")
			add_card_to_room(draw_new_card(), spawn)
	# add_card_to_room already updates, so no need to call update_room


func handle_card_interaction(card: Card) -> void:
	card.slot.remove_card()
	room.remove_child(card)

	pass


func _on_card_selected(card: Card) -> void:
	handle_card_interaction(card)
	update_room()
	if current_drawn_cards <= 1:
		print("[game] - Room empty, drawing more cards")
		fill_room_to_max()

	print("[game] - Selected Card: ", card.rank, " of ", card.suit)
