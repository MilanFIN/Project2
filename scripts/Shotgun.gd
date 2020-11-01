extends Weapon


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func fire():
	reduceAmmo()
	get_node("Muzzle").frame = 0
	get_node("Muzzle").play()
	for i in range(1,6):
		var ray =get_node("Shotgunray"+str(i))
		if (ray.is_colliding()):
			var target = ray.get_collider()
			if not(target is  TileMap):
				if (target.type == "Enemy"):
					target.act()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
