extends Control


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



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

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Start_pressed() -> void:
	print(listLevels())
	get_tree().change_scene("res://Game.tscn")
	pass # Replace with function body.
