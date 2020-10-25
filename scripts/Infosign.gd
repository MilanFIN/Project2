extends Actor

export var info = ""
var showInfo = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("InfoContainer").visible = showInfo
	get_node("InfoContainer/InfoLabel").text = info
	pass # Replace with function body.

func _process(delta):
	get_node("InfoContainer").visible = showInfo
	showInfo = false

func look():
	showInfo = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
