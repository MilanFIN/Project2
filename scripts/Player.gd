extends Actor


var tilemap = null
var healthBar


var speed = 300
var screenSize


var maxHp = 100.0
var hp = maxHp
var frostDps = 6.0
var runHealRate = 0.010
var warmHealRate = 10

var weapons = []
var currentWeapon = 0

var moveDirection = Vector2(0,0)

var actDelay = 333.0


var moveDistanceSinceFootprint = 0.0
var lastFootprint = 0 #type 0 to x

# Called when the node enters the scene tree for the first time.
func _ready():
	weapons.append(get_node("Knife"))
	weapons.append(get_node("Pistol"))
	weapons.append(get_node("Shotgun"))
	weapons.append(get_node("Grenade"))
	healthBar = get_tree().get_root().get_node("Game/HUD/HealthBar")


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
	
	moveDistanceSinceFootprint += velocity.length() * delta
	spawnFootprint()
	
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
	
	#only draw current weapon
	for i in weapons:
		if (i != weapons[currentWeapon]):
			i.visible = false
		else:
			i.visible = true
	
	
	if (get_node("SecondaryRay").is_colliding()):
		var target = get_node("SecondaryRay").get_collider()
		target.look()
	
	var hud = get_tree().get_root().get_node("Game/HUD")
	if (weapons[currentWeapon].ammo < 0):
		hud.get_node("AmmoCount").text = "∞"
	else:
		hud.get_node("AmmoCount").text = str(weapons[currentWeapon].ammo)
	hud.get_node("CurrentWeapon").text = str(weapons[currentWeapon].name)
#replace with configurable value


func takeDamage(dmg):
	self.hp -= dmg

func heal(amount):
	self.hp += amount

func setWeapon(weap):
	currentWeapon = weap

func primaryAction():
	if (OS.get_ticks_msec() - timeSinceLastAct > actDelay):
		actDelay = weapons[currentWeapon].getDelay()
		timeSinceLastAct = OS.get_ticks_msec()
		if (weapons[currentWeapon].hasAmmo()):
			weapons[currentWeapon].fire()
		else:
			outOfAmmo()
			

func secondaryAction():
	if (OS.get_ticks_msec() - timeSinceLastAct > actDelay):
		actDelay = 100
		timeSinceLastAct = OS.get_ticks_msec()
		if (get_node("SecondaryRay").is_colliding()):
			var target = get_node("SecondaryRay").get_collider()
			target.act()

func outOfAmmo():
	messageBox.showMessage("Out of ammo")


func addAmmo(weaponIndex, amount):
	weapons[weaponIndex].addAmmo(amount)

func checkAlive():
	if (hp <= 0):
		return false
	else:
		return true

	

func restart():
	#position = 32* Vector2(2, 3)
	hp = 100.0
	weapons[1].ammo = 0
	weapons[2].ammo = 0
	messageBox.showMessage("Game has restarted.")


func mapChange():
	hp = maxHp
	

func prevWeapon():
	if (currentWeapon > 0):
		currentWeapon -= 1
	else:
		currentWeapon = len(weapons) -1

func nextWeapon():

	if (currentWeapon < len(weapons)-1):
		currentWeapon += 1
	else:
		currentWeapon = 0

func spawnFootprint():
	
	if (moveDistanceSinceFootprint > 30):#15000
		lastFootprint += 1
		if (lastFootprint > 1):
			lastFootprint = 0
		var footprintRes = load("res://effects/Footprints.tscn")
		var footprint = footprintRes.instance()
		footprint.position = position
		footprint.rotation = rotation
		footprint.setStage(lastFootprint)
		get_parent().get_node("FootprintContainer").add_child(footprint)
		moveDistanceSinceFootprint = 0
