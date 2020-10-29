extends Node
class_name Ai


var entity
var player
var followDistance = 300


# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass # Replace with function body.

func init(e, p):
	entity = e
	player = p

func getDirection():

	
	var playerPos = player.position
	var entityPos = entity.position
	
	if (playerPos.distance_to(entityPos) < followDistance):
		return (playerPos - entityPos).normalized()
	else:
		return Vector2(0,0)


func shouldAttack(attackDistance):
	var playerPos = player.position
	var entityPos = entity.position
	return (playerPos.distance_to(entityPos) < attackDistance)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
