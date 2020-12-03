extends Control




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	VisualServer.set_default_clear_color(Color(0.2,0.2,0.2,1.0))
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_just_released("escape")):
		get_tree().change_scene("res://menu/Mainmenu.tscn")





func _on_Back_pressed() -> void:
	get_tree().change_scene("res://menu/Mainmenu.tscn")
	pass # Replace with function body.
