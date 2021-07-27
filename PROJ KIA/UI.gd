extends Node2D

var p1health = 300
var p2health = 300

func _process(delta):
	$Control/CanvasLayer/hp.text = str(p1health)
	$Control/CanvasLayer/hp2.text = str(p2health)
	
	
	
	if p1health < 1:
		get_tree().change_scene("res://testgrounds.tscn")
	if p2health < 1:
		get_tree().change_scene("res://testgrounds.tscn")
func _on_plr1_oof():
	p1health -= 5


func _on_plr1_bigoof():
	p1health -= 7


func _on_plr2_bigoof():
	p2health -= 7


func _on_plr2_oof():
	p2health -= 5


func _on_plr1_holyoof():
	p1health -= 12
