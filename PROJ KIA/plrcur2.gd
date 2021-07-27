extends KinematicBody2D


var up = Vector2.UP
var v = Vector2()
var turn = false
var character = 0

func _physics_process(delta):
	if turn == true:
		
		$plr2cursor.show()
		if Input.is_action_pressed("player2up"):
			v.y = -200
		elif Input.is_action_pressed("player2down"):
			v.y = 200
		elif Input.is_action_pressed("player2left"):
			v.x = -200
		elif Input.is_action_pressed("player2right"):
			v.x = 200
		else:
			v.x = 0
			v.y = 0
		
		if Input.is_action_just_pressed("player2select"):
			if character == 1:
				emit_signal("suma")
		
		
	else:
		$plr2cursor.hide()
	
	
	
	v = move_and_slide(v, up)
	
	
signal suma

func _on_Themaps_p1():
	turn = true


func _on_Themaps_p2():
	turn = true


func _on_Sunghitboox_area_entered(area):
	character = 1


func _on_Sunghitboox_area_exited(area):
	character = 0
