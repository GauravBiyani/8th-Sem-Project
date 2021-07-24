extends KinematicBody2D

var velocity = 50
var mouseSpeed = Vector2()
export var direction = -1

func _ready():
	if direction == 1:
		$AnimatedSprite.flip_h = true
	$FloorChecker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	
func _physics_process(delta):
	
	if is_on_wall() or not $FloorChecker.is_colliding() and is_on_floor():
		direction = direction * -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
		$FloorChecker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	mouseSpeed.y += 20
	
	mouseSpeed.x = velocity * direction
	
	mouseSpeed = move_and_slide(mouseSpeed, Vector2.UP)


func _on_TopChecker_body_entered(body):
	$AnimatedSprite.play("death")
	velocity = 0
	set_collision_layer_bit(4, false)
	set_collision_mask_bit(0, false)
	$TopChecker.set_collision_layer_bit(4, false)
	$TopChecker.set_collision_mask_bit(0, false)
	$SideChecker.set_collision_layer_bit(4, false)
	$SideChecker.set_collision_mask_bit(0, false)
	$Timer.start()
	body.bounce()
	$SoundDeath.play()


func _on_SideChecker_body_entered(body):
	body.player_hurt(position.x)


func _on_Timer_timeout():
	queue_free()
