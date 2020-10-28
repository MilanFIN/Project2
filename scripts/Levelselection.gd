extends Control


var levelList = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	levelList = listLevels()
	var levelcontainer = get_node("ScrollContainer/Levelcontainer")

	for level in levelList:
		var button = Button.new()
		button.text = level
		button.name = level
		button.connect("pressed", self, "_on_button_press", [button])
		levelcontainer.add_child(button)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func _on_button_press(button):
	Global.level = button.text
	get_tree().change_scene("res://Game.tscn")


	#get_tree().get_root().get_node("Game").changeMap(button.text)





func listLevels():
	var path = "res://levels"
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)

	dir.list_dir_end()
	var levels = []
	for i in range(len(files)):
		levels.append(files[i].split(".")[0])
	
	levels.sort()
	return levels
