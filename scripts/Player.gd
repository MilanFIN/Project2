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

#var weaponVisibility = [true, false, false] # melee, pistol, shotgun
#var ammo = [0,5,5] #melee, pistol, shotgun


var moveDirection = Vector2(0,0)

var actDelay = 333.0

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
	
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

