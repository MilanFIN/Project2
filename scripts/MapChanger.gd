extends Actor

export var targetMap = ""


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func act():
	messageBox.showMessage("Went to "+targetMap)
	#get_tree().get_root().get_node("Game/Player").position = Vector2(targetX, targetY)
	#get_tree().get_root().get_node("Game/Player").position *= 32
	get_tree().get_root().get_node("Game").changeMap(targetMap)

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
