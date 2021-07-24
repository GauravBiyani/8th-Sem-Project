extends KinematicBody2D

var on_ladder = false
var playerSpeed = Vector2(0,0)
const SPEED = 260
const JUMPSPEED = -800
const GRAVITY = 35
const UPSPEED = 40

func _physics_process(delta):
	if Input.is_action_pressed("right"):
		playerSpeed.x = SPEED
		$Sprite.play("Run")
		$Sprite.flip_h = false
	elif Input.is_action_pressed("left"):
		playerSpeed.x = -SPEED
		$Sprite.play("Run")
		$Sprite.flip_h = true
	else:
		$Sprite.play("Idle")
		
	if not is_on_floor():
		$Sprite.play("Jump")
	
	playerSpeed.y = playerSpeed.y + GRAVITY
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		playerSpeed.y = JUMPSPEED
		$SoundJump.play()
		
	playerSpeed = move_and_slide(playerSpeed,Vector2.UP)
	
	playerSpeed.x = lerp(playerSpeed.x,0,0.2)
	


func _on_FallZone_body_entered(body):
	get_tree().change_scene("res://GameOver.tscn")
	
func bounce():
	playerSpeed.y = JUMPSPEED * 0.7
	
func player_hurt(var posxEnemy):
	set_modulate(Color(255,255,255,255))
	playerSpeed.y = JUMPSPEED * 0.5
	
	if position.x < posxEnemy:
		playerSpeed.x = -800
	elif position.x > posxEnemy:
		playerSpeed.x = 800
		
	Input.action_release("left")
	Input.action_release("right")
	$Timer.start()


func _on_Timer_timeout():
	set_modulate(Color(1,1,1,1))
	
func CheckLadder():
	if on_ladder == true:
		if Input.is_action_pressed("climbup"):
			playerSpeed.y -= UPSPEED
		elif Input.is_action_pressed("climbdown"):
			playerSpeed.y += UPSPEED
