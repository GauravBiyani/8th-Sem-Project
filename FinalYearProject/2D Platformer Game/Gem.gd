extends Area2D


signal gem_collected

func _on_Gem_body_entered(body):
	queue_free()
	emit_signal("gem_collected")
	set_collision_mask_bit(0,false)
