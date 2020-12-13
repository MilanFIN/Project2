extends Control


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

	VisualServer.set_default_clear_color(Color(0.2,0.2,0.2,1.0))



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Start_pressed() -> void:

	get_tree().change_scene("res://menu/Levelselection.tscn")
	pass # Replace with function body.


func _on_Quit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.


func _on_Credits_pressed() -> void:
	get_tree().change_scene("res://menu/Credits.tscn")
	pass # Replace with function body.
