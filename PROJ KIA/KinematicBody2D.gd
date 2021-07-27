extends KinematicBody2D


var up = Vector2.UP
var v = Vector2()
var turn = true
var character = 0

func _physics_process(delta):
	if turn == true:
		
		$plr1cursor.show()
		if Input.is_action_pressed("player1up"):
			v.y = -200
		elif Input.is_action_pressed("player1down"):
			v.y = 200
		elif Input.is_action_pressed("player1left"):
			v.x = -200
		elif Input.is_action_pressed("player1right"):
			v.x = 200
		else:
			v.x = 0
			v.y = 0
		
		if Input.is_action_just_pressed("player1select"):
			if character == 1:
				emit_signal("suma")
		
		
	else:
		$plr1cursor.hide()
	
	
	
	
	
	
	
	v = move_and_slide(v, up)
	
	


func _on_Themaps_p2():
	turn = false


func _on_Sunghitboox_area_entered(area):
	character = 1

signal suma

func _on_Sunghitboox_area_exited(area):
	character = 0
