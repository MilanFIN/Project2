extends Actor


export var speed = 30
export var hp = 3
export var drop = ""


var velocity = Vector2.ZERO


var ai
var sprite

var timeSinceLastAction

var message = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	type = "Enemy"
	
	velocity.x = -speed
	velocity.y = speed
	
	ai = preload("res://scripts/Ai.gd").new()
	ai.init(self, get_tree().get_root().get_node("Game/Player"))
	sprite = get_node("Sprite")


func _physics_process(delta: float):
	move_and_slide(velocity)
	
	#if (is_on_wall()):
	#	var side = get_which_wall_collided()
	#	if (side == "left" or side == "right"):
	#		velocity.x *= -1
	#	if (side == "top" or side == "bottom"):
	#		velocity.y *= -1
	
	velocity = ai.getDirection() * speed
	if (velocity.x > 0):
		sprite.set_flip_h(true)
	else:
		sprite.set_flip_h(false)
		

	if (ai.shouldAttack()):
		if (OS.get_ticks_msec() - timeSinceLastAct > actDelay):
			timeSinceLastAct = OS.get_ticks_msec()
			var player = get_tree().get_root().get_node("Game/Player")
			player.takeDamage(3)
			messageBox.showMessage("a " +name+" attacked you")

	if (message != ""):
		messageBox.showMessage(message)
	message = ""


func act():
	var player = get_tree().get_root().get_node("Game/Player")

	var dmg = player.getDamage()
	hp -= dmg

	if (hp <= 0):
		message = "The " +name+" died"
		
		if (drop != ""):
			var dropFile = load("res://actors/"+drop+".tscn")
			var dropNode = dropFile.instance()
			get_parent().add_child(dropNode)
		queue_free()
	else:
		message = "You attacked a " + name




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float):
#	pass
