extends KinematicBody2D

var fuseMs = 2000
var initTime = 0
var speed = 100
var direction = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initTime = OS.get_ticks_msec()

	
	pass # Replace with function body.




func _physics_process(delta: float) -> void:
	if (OS.get_ticks_msec() - initTime > fuseMs):
		queue_free()
	
	move_and_slide(direction*speed)
	speed -= delta*10


func setDirection(dir):
	direction = dir
