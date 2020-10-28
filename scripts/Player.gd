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

var weapons = []
var currentWeapon = 0

#var weaponVisibility = [true, false, false] # melee, pistol, shotgun
#var ammo = [0,5,5] #melee, pistol, shotgun


var moveDirection = Vector2(0,0)



# Called when the node enters the scene tree for the first time.
func _ready():
	weapons.append(get_node("Knife"))
	weapons.append(get_node("Pistol"))
	weapons.append(get_node("Shotgun"))
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
	#get_node("melee").visible = weaponVisibility[0]
	#get_node("pistol").visible = weaponVisibility[1]
	#get_node("shotgun").visible = weaponVisibility[2]
	
	
	if (get_node("ActRay").is_colliding()):
		var target = get_node("ActRay").get_collider()
		target.look()
	
#replace with configurable value
func getDamage():
	return 1.0

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
	messageBox.showMessage("Game has restarted.")


	
	
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

