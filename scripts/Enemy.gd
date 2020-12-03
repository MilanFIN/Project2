extends Actor
class_name Enemy

export var speed = 30
export var hp = 3
var maxHp = 3
export var drop = ""
export var actDelay = 333
export var damage = 3
export var attackDistance = 50
export var followDistance = 300


var velocity = Vector2.ZERO


var ai
var sprite


var timeSinceLastAction

var message = ""

var effectExists = false
var visibleName = ""
var alive = true

# Called when the node enters the scene tree for the first time.
func _ready():
	
	maxHp = hp
	type = "Enemy"
	
	velocity.x = -speed
	velocity.y = speed
	
	ai = preload("res://scripts/Ai.gd").new()
	ai.init(self, get_tree().get_root().get_node("Game/Player"), followDistance)
	sprite = get_node("Sprite")

	var file2Check = File.new()
	visibleName = name
	for i in range(10):
		visibleName = visibleName.replace(str(i), "")


	effectExists = file2Check.file_exists("res://effects/"+visibleName+"attack.tscn")


func _physics_process(delta: float):
	move_and_slide(velocity)
	
	#if (is_on_wall()):
	#	var side = get_which_wall_collided()
	#	if (side == "left" or side == "right"):
	#		velocity.x *= -1
	#	if (side == "top" or side == "bottom"):
	#		velocity.y *= -1
	
	velocity = ai.getDirection() * speed
	if (velocity.length_squared() != 0):
		sprite.play()
	else:
		sprite.stop()
	var flip = false
	if (velocity.x > 0):
		flip = true
	else:
		flip = false
	if (flip != sprite.flip_h):
		rotateMuzzle()
	sprite.set_flip_h(flip)


	if (ai.shouldAttack(attackDistance)):
		if (OS.get_ticks_msec() - timeSinceLastAct > actDelay):
			timeSinceLastAct = OS.get_ticks_msec()
			attack()


	if (message != ""):
		messageBox.showMessage(message)
	message = ""
	
	showHp()


func attackAnimation():
	pass

func doDamage():
	var player = get_tree().get_root().get_node("Game/Player")
	player.takeDamage(damage)

	var attack
	if (effectExists):
		var attackFile = load("res://effects/"+visibleName+"attack.tscn")
		attack = attackFile.instance()
	else:
		var attackFile = load("res://effects/Genericattack.tscn")
		attack = attackFile.instance()
	player.add_child(attack)
	messageBox.showMessage("a " +visibleName+" attacked you")
	
	attackAnimation()


func attack():
	#shooter will do visibility checks here
	doDamage()

		

func takeDamage(dmg):
	hp -= dmg

	if (not alive):
		return
	var attack
	if (effectExists):

		var attackFile = load("res://effects/"+visibleName+"attack.tscn")

		attack = attackFile.instance()
	else:
		var attackFile = load("res://effects/Genericattack.tscn")
		attack = attackFile.instance()
	add_child(attack)

	if (hp <= 0):
		
		message = "The " +visibleName+" died"
		
		if (drop != ""):
			var dropFile = load("res://actors/"+drop+".tscn")
			var dropNode = dropFile.instance()
			dropNode.position = position
			get_parent().add_child(dropNode)
		alive = false
		
		die()
		
		

	else:
		message = "You attacked a " + name



func act():
	var player = get_tree().get_root().get_node("Game/Player")

	var dmg = player.getDamage()
	hp -= dmg

	if (hp <= 0):
		message = "The " +name+" died"
		
		if (drop != ""):
			var dropFile = load("res://actors/"+drop+".tscn")
			var dropNode = dropFile.instance()
			dropNode.position = position
			get_parent().add_child(dropNode)
		queue_free()
	else:
		message = "You attacked a " + visibleName

	var attack
	if (effectExists):
		var attackFile = load("res://effects/"+visibleName+"attack.tscn")
		attack = attackFile.instance()
	else:
		var attackFile = load("res://effects/Genericattack.tscn")
		attack = attackFile.instance()
	add_child(attack)


func rotateMuzzle():
	pass


func showHp():
	pass

func die():
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float):
#	pass
