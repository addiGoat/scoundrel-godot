extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for card in get_children():
		if card is Card:
			card.selected.connect(_on_card_selected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_card_selected(card: Variant) -> void:
	print("Game recieved selection: ", card.card_rank, " of ", card.card_suit)
