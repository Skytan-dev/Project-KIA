extends KinematicBody2D


var v = Vector2()
var up = Vector2.UP
func _physics_process(delta):
	v.y += 30
	
	v = move_and_slide(v, up)



func _on_KinematicBody2D_hi():
	v.y -= 230
	print("HIT")


func _on_KinematicBody2D_hello():
	v.y -= 600
	print("HSIT")
