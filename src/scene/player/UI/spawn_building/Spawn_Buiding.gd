extends Control


func _process(delta):
	
	$mouse.global_position = get_global_mouse_position()

#func _on_button_button_down():
	#GameManager.CurrentState =  GameManager.State.Buildling
	#pass


func _on_area_2d_area_entered(area):
	BuildManeger.subBuild = false


func _on_area_2d_area_exited(area):
	BuildManeger.subBuild = true
	

func _on_button_pressed():
	
	BuildManeger.Spawn_Mining_Iron()
