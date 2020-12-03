extends Actor

var fuseMs = 2000
var initTime = 0
var speed = 150
var direction = Vector2(0,0)
var damage = 3

var exploded = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initTime = OS.get_ticks_msec()

	
	pass # Replace with function body.




func _physics_process(delta: float) -> void:
	
	if (not exploded):
		if (OS.get_ticks_msec() - initTime > fuseMs):
			get_node("Sprite").visible = false
			get_node("Muzzle").frame = 0
			get_node("Muzzle").play()
			explode()
			exploded = true

	
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
	
	get_node("AudioStreamPlayer").play()
	var area = get_node("ExplosionRange")
	var overlappingBodies = area.get_overlapping_bodies()
	for i in overlappingBodies:

		i.takeDamage(damage)



func _on_Muzzle_animation_finished() -> void:
	queue_free()
	pass # Replace with function body.
