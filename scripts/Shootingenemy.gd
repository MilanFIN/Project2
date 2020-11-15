extends Enemy


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	type = "Enemy"
	pass # Replace with function body.

func clearSight():
	var playerPos = get_tree().get_root().get_node("Game/Player").position
	
	var ray = get_node("ShotRay")
	ray.cast_to = Vector2(playerPos - position)
	if (ray.is_colliding()):
		return false
	else:
		return true


func attackAnimation():
	get_node("Muzzle").frame = 0
	get_node("Muzzle").play()
	
func attack():
	if (clearSight()):
		doDamage()
		
func rotateMuzzle():
	var muzzle = get_node("Muzzle")
	muzzle.position.x = -muzzle.position.x
	muzzle.rotation_degrees =  fmod(muzzle.rotation_degrees + 180, 360)
