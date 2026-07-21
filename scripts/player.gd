class_name Player
extends Node2D

signal player_died

const character_name = "addi"

@export var max_hp: int = 20
@export var starting_weapon_damage: int = 0

var current_hp: int
var weapon_damage: int
var weapon_recently_equipped: bool = false

@onready var health_label: Label = $HealthLabel
@onready var weapon_label: Label = $WeaponLabel


func _init() -> void:
	current_hp = max_hp
	weapon_damage = starting_weapon_damage


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func heal(amount: int) -> void:
	current_hp = min(max_hp, current_hp + amount)
	update_display()


func equip_weapon(damage: int) -> void:
	print("[player] - equip_weapon called")
	weapon_damage = damage
	weapon_recently_equipped = true
	update_display()


func take_damage(damage: int) -> void:
	print("[player] - take_damage called")
	print("Damage: ", damage)
	print("Weapon Damage: ", weapon_damage)

	var damage_taken: int

	# If weapon equipped.
	if weapon_damage != 0:
		# If first attack after equipping
		if weapon_recently_equipped:
			weapon_recently_equipped = false

			# If attack damage is higher than weapon damage, apply remaining damage 
			if damage > weapon_damage:
				damage_taken = damage - weapon_damage
			weapon_damage = damage

		# Subsequent weapon attacks
		elif !weapon_recently_equipped:
			# If damage is lower than weapon damage, equip new weapon and block everything
			if damage < weapon_damage:
				weapon_damage = damage
				damage_taken = 0
			else:
				damage_taken = damage
	else:
		damage_taken = damage

	current_hp = max(0, current_hp - damage_taken)
	update_display()
	if current_hp <= 0:
		player_died.emit()


func update_display() -> void:
	health_label.text = str(current_hp)
	weapon_label.text = str(weapon_damage)
