extends Area2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
export var ammoType = 0
export var ammoAmount = 0
var messageBox
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	messageBox = get_tree().get_root().get_node("Game/HUD/Messages")
	pass # Replace with function body.


func _on_Ammo_body_entered(body: Node) -> void:
	var player = get_tree().get_root().get_node("Game/Player")
	messageBox.showMessage("Picked up some ammo")
	player.addAmmo(ammoType, ammoAmount)
	
	queue_free()
	pass # Replace with function body.
