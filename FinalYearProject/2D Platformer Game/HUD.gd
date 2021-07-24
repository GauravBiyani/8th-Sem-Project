extends CanvasLayer

var gems = 0

func _ready():
	$N_gems.text = String(gems)


func _on_gem_collected():
	gems = gems + 1
	_ready()
	if gems == 24:
		get_tree().change_scene("res://Win.tscn")
