class_name Player
extends Node2D

signal player_died

const character_name = "addi"

@export var MaxHP = 20

var current_hp

@onready var health_label: Label = $HealthLabel


func _init() -> void:
	current_hp = MaxHP


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func take_damage(damage: int) -> void:
	print(character_name, " takes ", damage, " damage!")
	current_hp -= damage
	update_display()

	if current_hp <= 0:
		player_died.emit()


func update_display() -> void:
	health_label.text = str(current_hp)
