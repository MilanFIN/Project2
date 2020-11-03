extends Node2D


var tilemap = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	start()
	VisualServer.set_default_clear_color(Color(0,0,0,1.0))



func start():
	changeMap(Global.level)
	get_node("Player").restart()

func changeMap(mapname):
	
	var levelContainer = get_node("LevelContainer")
	var player = get_node("Player")
	for n in levelContainer.get_children():
		n.queue_free()
	var mapFile = load("res://levels/"+mapname+".tscn")
	var mapNode = mapFile.instance()
	mapNode.name = mapname
	mapNode.position = Vector2(0,0)
	levelContainer.add_child(mapNode)
	
	
	player.position = Vector2(mapNode.startX, mapNode.startY) * 32 + Vector2(16, 16)
	player.mapChange()
	tilemap = mapNode.get_node("TileMap")
	player.tilemap = mapNode.get_node("TileMap")

	get_node("HUD/LevelName").text = mapname
	Global.level = mapname


func _physics_process(delta: float) -> void:
	var player = get_node("Player")

	var moveDirection = Vector2(0,0)
	if Input.is_action_pressed("move_left"):
		moveDirection.x = -1
	if Input.is_action_pressed("move_right"):
		moveDirection.x = 1
	if Input.is_action_pressed("move_up"):
		moveDirection.y = -1
	if Input.is_action_pressed("move_down"):
		moveDirection.y = 1
	player.moveDirection = moveDirection
	
	
	if Input.is_action_pressed("melee"):
		player.setWeapon(0)
	if Input.is_action_pressed("pistol"):
		player.setWeapon(1)
	if Input.is_action_pressed("shotgun"):
		player.setWeapon(2)
	if Input.is_action_pressed("grenade"):
		player.setWeapon(3)
	
	if (Input.is_mouse_button_pressed(BUTTON_LEFT)):
		player.primaryAction()

	if (Input.is_mouse_button_pressed(BUTTON_RIGHT)):
		player.secondaryAction()
	if (not player.checkAlive()):
		start()


func _input(event):

	if event is InputEventMouseButton:
		if event.is_pressed():
			var player = get_node("Player")
			if event.button_index == BUTTON_WHEEL_UP:
				player.prevWeapon()
	
			if event.button_index == BUTTON_WHEEL_DOWN:
				player.nextWeapon()

