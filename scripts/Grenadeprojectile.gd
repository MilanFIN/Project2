extends KinematicBody2D

var fuseMs = 2000
var initTime = 0
var speed = 150
var direction = Vector2(0,0)
var damage = 3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initTime = OS.get_ticks_msec()

	
	pass # Replace with function body.




func _physics_process(delta: float) -> void:
	if (OS.get_ticks_msec() - initTime > fuseMs):
		explode()
		queue_free()
	
	#move_and_slide(direction*speed)
	#Vector2 x, y
	var movement = move_and_slide(direction*speed)
	if (movement.x == 0):
		direction.x = -direction.x
	if (movement.y == 0):
		direction.y = -direction.y
	speed -= delta*100
	speed = abs(speed)


func setDirection(dir):
	direction = dir

func explode():
	var area = get_node("ExplosionRange")
	var overlappingBodies = area.get_overlapping_bodies()
	for i in overlappingBodies:

		i.takeDamage(damage)

