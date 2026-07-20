class_name Card
extends Node2D

signal selected(card)

@export var card_rank: int = 7
@export var card_suit: String = "Diamonds"

@onready var rank_label: Label = $RankLabel
@onready var suit_label: Label = $SuitLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_display()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func update_display() -> void:
	rank_label.text = str(card_rank)
	suit_label.text = card_suit


func _on_click_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			# print(card_rank, " of ", card_suit)
			selected.emit(self)
