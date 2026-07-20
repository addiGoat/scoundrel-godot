extends Marker2D

var occupant: Card = null


func is_empty() -> bool:
	if occupant == null:
		return true
	else:
		return false


func place_card(card: Card) -> void:
	occupant = card
	card.position = self.position


func remove_card() -> void:
	occupant = null
