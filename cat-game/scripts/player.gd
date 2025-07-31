extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var right_wall: Area2D = $"../Boundaries/RightWall"
@onready var left_wall: Area2D = $"../Boundaries/LeftWall"
@onready var bottom_wall: Area2D = $"../Boundaries/BottomWall"
@onready var top_wall: Area2D = $"../Boundaries/TopWall"
@onready var camera: Camera2D =$"../Camera2D"

var boundaryDict = { "isHit": false, "wall": "" }
const SPEED = 200.0
var view_width = 0
var view_height = 0

func _ready() -> void:
	right_wall.connect("body_entered", _on_player_boundary.bind("Right"))
	left_wall.connect("body_entered", _on_player_boundary.bind("Left"))
	top_wall.connect("body_entered", _on_player_boundary.bind("Top"))
	bottom_wall.connect("body_entered", _on_player_boundary.bind("Bottom"))
	var camera_size = (camera.get_viewport_rect().size / camera.zoom)/2
	view_width = camera_size[0]
	view_height = camera_size[1]
	print("VIEW_WIDTH", view_width)
	print("VIEW_HEIGHT", view_height)
	position.x = 0
	position.y = 0

	
func _physics_process(delta: float) -> void:
	print("position.x", position.x)
	# Get the input direction: -1, 0 , 1
	var horz_direction := Input.get_axis("move_left", "move_right")
	var vert_direction := Input.get_axis("move_up", "move_down")
	
	if horz_direction > 0:
		animated_sprite.play("move-right")
		velocity.x = horz_direction * SPEED
	elif horz_direction < 0:
		animated_sprite.play("move-left")
		velocity.x = horz_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if vert_direction > 0:
		velocity.y = vert_direction * SPEED
		animated_sprite.play("move-down")
	elif vert_direction < 0:
		velocity.y = vert_direction * SPEED
		animated_sprite.play("move-up")
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	#if position.x >= view_width:
		#position.x = -view_width 
	#if position.x <= 5:
		#position.x = get_viewport().size.x + -5
		
	if vert_direction == 0 and horz_direction == 0:
		animated_sprite.stop()

	move_and_slide()
	
func _on_player_boundary(body: Node, boundary: String):
	boundaryDict["isHit"] = true;
	boundaryDict["wall"] = boundary
	
