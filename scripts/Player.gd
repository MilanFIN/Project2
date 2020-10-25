extends Actor


var tilemap = null
var healthBar


var speed = 300
var screenSize


var maxHp = 100.0
var hp = maxHp
var frostDps = 3.0
var runHealRate = 0.010
var warmHealRate = 2



var weaponVisibility = [true, false, false] # melee, pistol, shotgun
var ammo = [0,5,5] #melee, pistol, shotgun


var moveDirection = Vector2(0,0)



# Called when the node enters the scene tree for the first time.
func _ready():
	healthBar = get_tree().get_root().get_node("Game/HUD/HealthBar")
	pass # Replace with function body.

func _physics_process(delta):

		
	var screenSize = get_viewport_rect().size
	var mousePos = get_viewport().get_mouse_position()
	var cameraPos = screenSize/ 2

	#cameraPos.x = clamp(cameraPos.x, 0, screenSize.x)
	#cameraPos.y = clamp(cameraPos.y, 0, screenSize.y)

	var newAngle = cameraPos.angle_to_point(mousePos)
	rotation = fmod(newAngle, 360)


	var velocity = moveDirection * speed
	move_and_slide(velocity)
	
	moveDirection = Vector2(0,0)
	
	#handle hp
	if (tilemap != null):
		var tile = tilemap.get_cellv(tilemap.world_to_map(position))
		if (tile == tilemap.tile_set.find_tile_by_name("warmfloor")):
			hp += warmHealRate * delta
		else:
			#take enviromental damage
			hp -= delta*frostDps 
			hp += velocity.length() * runHealRate * delta
		if (hp > 100):
			hp = 100.0
	else:
		pass
		#print(OS.get_ticks_msec())
	healthBar.setHp(hp, maxHp)
	
	#show weapons
	get_node("melee").visible = weaponVisibility[0]
	get_node("pistol").visible = weaponVisibility[1]
	get_node("shotgun").visible = weaponVisibility[2]
	
	
	if (get_node("ActRay").is_colliding()):
		var target = get_node("ActRay").get_collider()
		target.look()
	
#replace with configurable value
func getDamage():
	return 1.0

func takeDamage(dmg):
	self.hp -= dmg


func changeToMelee():
	weaponVisibility = [false, false, false]
	weaponVisibility[0] = true

func changeToPistol():
	weaponVisibility = [false, false, false]
	weaponVisibility[1] = true
	
func changeToShotgun():
	weaponVisibility = [false, false, false]
	weaponVisibility[2] = true

func primaryAction():
	if (OS.get_ticks_msec() - timeSinceLastAct > actDelay):
		timeSinceLastAct = OS.get_ticks_msec()
		if (weaponVisibility[0]):
			useMelee()
		if (weaponVisibility[1]):
			shootPistol()
		if (weaponVisibility[2]):
			shootShotgun()


func useMelee():
	get_node("melee").frame = 0
	get_node("melee").play()
	if (get_node("ActRay").is_colliding()):
		var target = get_node("ActRay").get_collider()
		target.act()

func shootPistol():
	if (ammo[1] > 0):
		ammo[1] -= 1
		get_node("pistol").frame = 0
		get_node("pistol").play()
		var bulletRay = get_node("BulletRay")
		if (bulletRay.is_colliding()):
			var target = bulletRay.get_collider()
			if not(target is  TileMap):
				if (target.type == "Enemy"):
					target.act()
	else:
		outOfAmmo()

func shootShotgun():
	if (ammo[2] > 0):
		ammo[2] -= 1
		get_node("shotgun").frame = 0
		get_node("shotgun").play()
		var dmg = 0
		for i in range(1,6):
			var ray =get_node("Shotgunray"+str(i))
			if (ray.is_colliding()):
				var target = ray.get_collider()
				if not(target is  TileMap):
					if (target.type == "Enemy"):
						target.act()
	else:
		outOfAmmo()

func outOfAmmo():
	print("out of ammo")


func checkAlive():
	if (hp <= 0):
		return false
	else:
		return true

	

func restart():
	#position = 32* Vector2(2, 3)
	hp = 100.0
	messageBox.showMessage("Game has restarted.")


	
	
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

