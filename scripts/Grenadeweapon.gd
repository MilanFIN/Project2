extends Weapon






# Called when the node enters the scene tree for the first time.
func _ready() -> void:


	pass # Replace with function body.



func fire():
	reduceAmmo()

	var grndfile = load("res://actors/Grenadeprojectile.tscn")
	var grenadeProj = grndfile.instance()


	
	var dir = Vector2(-1,0).rotated(global_rotation)
	
	grenadeProj.setDirection(dir)
	
	grenadeProj.position = get_parent().position + dir * 30
	get_parent().get_parent().add_child(grenadeProj)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
