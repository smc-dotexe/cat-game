extends CharacterBody2D

const SPEED = 2
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var boundaries: Node = $Boundaries

func _process(delta: float) -> void:	
	position.x -= SPEED*1
	


func on_mouse_entered_tree(node: Node) -> void:
	print("HIT")
