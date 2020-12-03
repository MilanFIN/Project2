extends Weapon


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	damage = 2
	pass # Replace with function body.

func fire():
	reduceAmmo()

	get_node("AudioStreamPlayer").play()

	get_node("Muzzle").frame = 0
	get_node("Muzzle").play()
	if (get_node("fireRay").is_colliding()):
		var target = get_node("fireRay").get_collider()
		if (not(target is  TileMap) and not(target is StaticBody2D)):
			if (target != null):
				if (target.type == "Enemy"):
					target.takeDamage(damage)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
