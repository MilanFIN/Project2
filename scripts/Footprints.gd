extends Node2D


var lifeleft = 3 #seconds
var lifetime = lifeleft
# Called when the node enters the scene tree for the first time.
func _ready() -> void:


	pass # Replace with function body.


func _process(delta: float) -> void:
	lifeleft -= delta
	modulate.a = lifeleft/lifetime

	if (lifeleft < 0):
		queue_free()

func setStage(stage):
	if (stage != 0):
		get_node("Sprite").flip_h = true
