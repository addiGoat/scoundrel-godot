class_name Card
extends Node2D

signal selected(card)

@export var rank: int = 7
@export var suit: String = "Diamonds"

var slot

@onready var rank_label: Label = $RankLabel
@onready var suit_label: Label = $SuitLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_display()


func update_display() -> void:
	rank_label.text = str(rank)
	suit_label.text = suit


func set_card_data(data: Dictionary) -> void:
	suit = data["Suit"]
	rank = data["Rank"]


func _on_click_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			selected.emit(self)
