extends Node2D

@onready var round_timer: Timer = $Timer
@onready var countdown: Label = $Countdown
@onready var camera: Camera2D = $Camera2D
@onready var boundaries: Node = $Boundaries
@onready var right_wall: Area2D = $Boundaries/RightWall
@onready var left_wall: Area2D = $Boundaries/LeftWall
@onready var top_wall: Area2D = $Boundaries/TopWall
@onready var bottom_wall: Area2D = $Boundaries/BottomWall
 

const MOUSE_SCENE = preload("res://scenes/mouse.tscn")
const ROUNDTIMER = 30
var mouse_timer: Timer = Timer.new()
var mouse_interval = randi_range(3, 7)
@onready var mouse: CharacterBody2D = $Mouse

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	round_timer.start(ROUNDTIMER)
	
	add_child(mouse_timer)
	mouse_timer.start(mouse_interval)	 
	print("mouse interval", mouse_interval)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	countdown.text = str(int(round_timer.time_left))
	var cat = get_node("Player")
	
	if round_timer.time_left < ROUNDTIMER and round_timer.time_left > 0 :
		if int(mouse_timer.time_left) == 0 and not has_node("Mouse"):			
			var mouse = MOUSE_SCENE.instantiate()
			mouse.name = "Mouse"
			add_child(mouse)
			mouse.position = Vector2(0, 10)
			mouse_interval = randi_range(3, 7)
	

	var viewport = camera.get_viewport_rect()
	if has_node("Mouse"):
		var mouse = get_node("Mouse")
		if mouse.position.x >= viewport.size[0]:
			print("Mouse queue free")
			mouse.queue_free()

func _on_boundary_entered(body: Node, boundary: String) -> void:
	if body == $Mouse:
		print("Mouse hit ", boundary, " boundary!")
		var mouse_node = get_node("Mouse")
		mouse_node.queue_free()
	#if body == $Player:
		#print("Player hit")
		#var player = get_node("Player")
		#var offset = 5.0  # Distance to push back from boundary
		#match boundary:
			#"Right":
				#player.position.x -= offset
			#"Left":
				#player.position.x += offset
			#"Top":
				#player.position.y += offset
			#"Bottom":
				#player.position.y -= offset
	
