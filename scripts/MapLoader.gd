extends Node


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var tileDict = {
	"#": "wall",
	".": "floor",
	"w": "warmfloor",
}

var mapChangers = [
	"Ladder",
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _load_text_file(path):
	var f = File.new()
	var err = f.open(path, File.READ)
	if err != OK:
		return ""
	var text = f.get_as_text()
	f.close()
	
	var textArray = text.split("\n")
	
	return textArray


func loadEntities(tilemap, entityContainer, mapname):
	#clear old entities
	for n in entityContainer.get_children():
		entityContainer.remove_child(n)
		n.queue_free()
	#load corresponding entities
	var config = ConfigFile.new()
	var err = config.load("res://maps//"+mapname+"_entities.cfg")
	if err == OK: # If not, something went wrong with the file loading
		var sections = config.get_sections()

		for s in sections:
			var type = config.get_value(s, "type")
			var x = config.get_value(s, "x")
			var y = config.get_value(s, "y")

			var newEntityResource = load("res://actors/"+type+".tscn")
			var newEntity = newEntityResource.instance()
			
			var relativePos = tilemap.map_to_world(Vector2(x, y)) + tilemap.cell_size /2
			
			newEntity.position = relativePos 
			entityContainer.add_child(newEntity)
			
			if (type  in mapChangers):
				newEntity.targetMap = config.get_value(s, "exitmap")
				newEntity.targetX = config.get_value(s, "exitx")
				newEntity.targetY = config.get_value(s, "exity")
			


func loadMap(mapname):
	pass
	
	#tilemap.clear() #empty before doing anything else
	#var test = _load_text_file("res://maps/"+mapname+"_static.txt")
	#for y in range(test.size()):
	#	for x in range(test[y].length()):
	#		var tile_id = tilemap.tile_set.find_tile_by_name(tileDict[test[y][x]])
	#		tilemap.set_cell(x, y, tile_id)
	

	#loadEntities(tilemap, entityContainer, mapname)


	#get_tree().get_root()#.get_node("Game/Player")
	#player.position.x = x*tilemap.cell_size
	#player.position.y = y*tilemap.cell_size

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
