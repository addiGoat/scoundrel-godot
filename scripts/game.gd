extends Node2D

const CARD_SCENE = preload("res://scenes/card.tscn")

var room_size: int = 4
var current_drawn_cards = 0

@onready var deck: Deck = $Deck
@onready var room: Node2D = $Room
@onready var card_spawns = room.find_children("CardSpawn?")
@onready var marker: Marker2D = $Room/CardSpawn1
@onready var player: Player = $Player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# draw_new_card()
	fill_room_to_max()

	player.player_died.connect(_on_player_died)
	deck.print_deck_info()


func update_room() -> void:
	current_drawn_cards = 0
	for c in room.get_children():
		if c is Card:
			current_drawn_cards = current_drawn_cards + 1

	print(current_drawn_cards)


func draw_new_card() -> Card:
	if deck.is_empty():
		return null

	var card: Card = CARD_SCENE.instantiate()
	card.set_card_data(deck.get_card())

	# Connecting it to the on_selected signal
	card.selected.connect(_on_card_selected)
	return card


func add_card_to_room(card: Card, spawn) -> void:
	if card == null:
		return
	card.slot = spawn
	spawn.place_card(card)
	room.add_child(card)
	update_room()


func fill_room_to_max() -> void:
	for spawn in card_spawns:
		if spawn.is_empty():
			print(spawn, " is empty.")
			add_card_to_room(draw_new_card(), spawn)

	player.has_healed_this_turn = false


func handle_card_interaction(card: Card) -> void:
	match card.suit:
		"POTION":
			print("Potion card selected")
			if !player.has_healed_this_turn:
				player.heal(card.rank)
				player.has_healed_this_turn = true
				print("player has already healed this turn")
		"MONSTER":
			print("Monster card selected")
			player.take_damage(card.rank)
		"WEAPON":
			print("Weapon card selected")
			player.equip_weapon(card.rank)
		"SPELL":
			print("Spell card selected")
		_:
			print("unrecognized suit")
	card.slot.remove_card()
	room.remove_child(card)


func _on_card_selected(card: Card) -> void:
	handle_card_interaction(card)
	update_room()
	if current_drawn_cards <= 1:
		print("[game] - Room empty, drawing more cards")
		fill_room_to_max()


func _on_player_died() -> void:
	print("[game] - player died, game over")
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
