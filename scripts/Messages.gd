extends Label



var messages = []




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass



func showMessage(msg):
	messages.append(msg)

	if (len(messages) > 8):
		messages = messages.slice(len(messages)-9, len(messages)-1)
	text = ""
	for i in messages:
		text += i + "\n"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
