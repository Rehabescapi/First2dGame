extends Area2D

export var speed = 400 
#var means this is a variable that holds a value of 400
#export means that another file with be paying attention.
#How fast the player will move ie 400 (pixels/sec).

var screen_size # Size of the game window.


#func is short for function. This is a repeatable action.
# the '_' Underscore before the name means that it works directly with godot.

func _ready(): #Do this when the scene is loaded. 
	screen_size = get_viewport_rect().size
#Do this at every frame the game loops with.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	#Update the position of the player at each tick. 
	position += velocity * delta
	#clamp function stops the player from going out of the screen 
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	
	
	#If the squid is moving animate.
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	#If the player direction is going left or right.
	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		# See the note below about boolean assignment.
		$AnimatedSprite.flip_h = velocity.x < 0
		#if Going up or down.
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0
		
		
	
