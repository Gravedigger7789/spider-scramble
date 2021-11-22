extends Position2D
class_name Weapon

const Projectile := preload("res://src/Weapons/Projectile.tscn")

onready var cooldown_timer: Timer = $Cooldown
onready var attack_sound: AudioStreamPlayer = $AttackSound

func attack() -> bool:
	var has_attacked := false
	if cooldown_timer.is_stopped():
		cooldown_timer.start()
		var projectile = Projectile.instance()
		projectile.global_position = global_position
		projectile.set_as_toplevel(true)
		attack_sound.play()
		add_child(projectile)
		has_attacked = true
	return has_attacked
