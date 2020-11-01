extends Weapon


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ammo = -1
	damage = 1
	pass # Replace with function body.

func fire():
	get_node("Sprite").frame = 0
	get_node("Sprite").play()
	if (get_node("fireRay").is_colliding()):
		var target = get_node("fireRay").get_collider()
		target.takeDamage(damage)
