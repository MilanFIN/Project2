extends KinematicBody2D
class_name Actor

var messageBox

var timeSinceLastAct = OS.get_ticks_msec()


var type = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	messageBox = get_tree().get_root().get_node("Game/HUD/Messages")

func get_which_wall_collided():
	for i in range(get_slide_count()):
		var collision = get_slide_collision(i)
		if collision.normal.x > 0:
			return "left"
		elif collision.normal.x < 0:
			return "right"
		if collision.normal.y > 0:
			return "bottom"
		elif collision.normal.y < 0:
			return "top"
			
	return "none"


func act():
	pass

func look():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
