extends Area2D



export var healAmount = 20

var messageBox


func _ready() -> void:
	messageBox = get_tree().get_root().get_node("Game/HUD/Messages")



func _on_Healthpickup_body_entered(body: Node) -> void:
	var player = get_tree().get_root().get_node("Game/Player")
	messageBox.showMessage("Picked up some health")
	player.heal(healAmount)
	
	queue_free()

