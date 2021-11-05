class_name Weapon
extends Position2D

const Projectile := preload("res://src/Objects/Projectile.tscn")

onready var cooldown_timer := $Cooldown

var can_attack := true

func attack() -> void:
	if can_attack:
		can_attack = false
		cooldown_timer.start()
		var projectile = Projectile.instance()
		projectile.global_position = global_position
		projectile.set_as_toplevel(true)
		add_child(projectile)

func _on_Cooldown_timeout() -> void:
	can_attack = true
