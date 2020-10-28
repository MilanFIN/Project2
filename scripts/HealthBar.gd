extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var hp = 0
var maxHp = 100

const X = 320
const Y = 516
const HEIGHT = 32
var MAXWIDTH = 192

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func drawBar(width):
	
	var background = PoolColorArray([Color(1.0, 0.0, 0.0)])

	var backgroundPoints = PoolVector2Array()
	backgroundPoints.push_back(Vector2(X,Y))
	backgroundPoints.push_back(Vector2(X+MAXWIDTH,Y))
	backgroundPoints.push_back(Vector2(X+MAXWIDTH,Y+HEIGHT))
	backgroundPoints.push_back(Vector2(X,Y+HEIGHT))

	draw_polygon(backgroundPoints, background)
	
	var color = PoolColorArray([Color(0.0, 1.0, 0.0)])

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
