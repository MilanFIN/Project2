extends Enemy
class_name BossEnemy

func showHp():

	var fraction = float(hp)/maxHp
	var green = get_node("Control/Panel/Green")
	var red = get_node("Control/Panel/Red")
	var maxWidth = red.rect_size.x
	green.rect_size.x = maxWidth * fraction


func die():
	get_tree().change_scene("res://menu/Endscreen.tscn")
	queue_free()
