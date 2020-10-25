extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var hp = 0
var maxHp = 100

const X = 64
const Y = 500
const HEIGHT = 20
var MAXWIDTH = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func drawBar(width):
	var color = PoolColorArray([Color(1.0, 0.0, 0.0)])
	var points = PoolVector2Array()
	points.push_back(Vector2(X,Y))
	points.push_back(Vector2(X+width,Y))
	points.push_back(Vector2(X+width,Y+HEIGHT))
	points.push_back(Vector2(X,Y+HEIGHT))

	draw_polygon(points, color)
	#draw_line(Vector2(10,10), Vector2(100,10), color)
	
	
func _draw():
	var width = hp/maxHp*MAXWIDTH
	drawBar(width)



func setHp(health, maxHealth):
	hp = health
	maxHp = maxHealth
	update()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
