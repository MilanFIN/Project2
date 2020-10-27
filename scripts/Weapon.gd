extends Node2D
class_name Weapon

var ammo = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func hasAmmo():
	return ammo != 0
	
func reduceAmmo():
	if (ammo > 0):
		ammo -= 1

func addAmmo(amount):
	ammo += amount
	
func fire():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
