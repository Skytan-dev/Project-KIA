extends KinematicBody2D

var up = Vector2.UP
var v = Vector2()
var mvmsp = 300

var facingRight = true
export var hitting = false

#collision
var rph = false
var lph = false

var harder = 0

var whiffing = false
var whifftime = 10
func _physics_process(delta):
	
	
	v.y += 30
	#whiff mechanic (BELH I WDUIOADHUIODHIODHAODHIODIO)
	if whiffing:
		if is_on_floor():
			v.x = 0
	whifftime -= 1
	if whifftime < 0:
		whifftime = 0
		hitting = false
		whiffing = false
	#movement
	if !whiffing:
		if is_on_floor():
			if Input.is_action_just_pressed("jump"):
				v.y -= 700
				$AnimationPlayer.play("jump")
		else:
			$AnimationPlayer.play("jump")
		if facingRight:
			
			$Sprite.scale.x = 1
		else:
			
			
			$Sprite.scale.x = -1
		if Input.is_action_pressed("left"):
			if !whiffing:
				v.x = -mvmsp
				facingRight = false
				if is_on_floor():
					$AnimationPlayer.play("walk")
		elif Input.is_action_pressed("right"):
			if !whiffing:
				v.x = mvmsp
				facingRight = true
				if is_on_floor():
					$AnimationPlayer.play("walk")
		else:
			if is_on_floor():
				v.x = 0
				if !whiffing:
					$AnimationPlayer.play("idle")
			
	
	#jab
	if !whiffing:
		if Input.is_action_just_pressed("j"):
			if is_on_floor():
				harder = 0
				if !facingRight:
					$phb/CollisionShape2D.position.x = -9.188
					$phb/CollisionShape2D.position.y = 1.912
				else:
					$phb/CollisionShape2D.position.x = 10.688
					$phb/CollisionShape2D.position.y = 1.912
				$AnimationPlayer.play("Punch")
				whifftime = 5
				whiffing = true
			else:
				if v.y > 60:
					harder = 1
					if !facingRight:
						$phb/CollisionShape2D.position.x = -11.269
						$phb/CollisionShape2D.position.y = -4.125
					else:
						$phb/CollisionShape2D.position.x = 11.257
						$phb/CollisionShape2D.position.y = -4.125
					$AnimationPlayer.play("uppercut")
					whifftime = 20
					whiffing = true
				else:
					harder = 0
					if !facingRight:
						$phb/CollisionShape2D.position.x = -8.596
						$phb/CollisionShape2D.position.y = 6.888
					else:
						$phb/CollisionShape2D.position.x = 10.32
						$phb/CollisionShape2D.position.y = 6.888
					$AnimationPlayer.play("airpunch")
					whifftime = 20
					whiffing = true
		
		#kiik
		if Input.is_action_just_pressed("k"):
			if is_on_floor():
				harder = 1
				if !facingRight:
					$phb/CollisionShape2D.position.x = -9.188
					$phb/CollisionShape2D.position.y = 9.105
				else:
					$phb/CollisionShape2D.position.x = 10.688
					$phb/CollisionShape2D.position.y = 9.105
				$AnimationPlayer.play("kick")
				whifftime = 20
				whiffing = true
			else:
				harder = 1
				if !facingRight:
					$phb/CollisionShape2D.position.x = -8.15
					$phb/CollisionShape2D.position.y = 9.36
				else:
					$phb/CollisionShape2D.position.x = 9.688
					$phb/CollisionShape2D.position.y = 9.36
				$AnimationPlayer.play("airkick")
				whifftime = 30
				whiffing = true
	
	
	
	
	v = move_and_slide(v, up)


func _on_phb_body_shape_entered(body_id, body, body_shape, local_shape):
	hihihi = true




func _on_phb_body_shape_exited(body_id, body, body_shape, local_shape):
	hihihi = false



#temp

var hihihi = false


signal hi
signal hello
func _process(delta):
	if hihihi == true:
		if hitting:
			hitting = false
			if harder == 1:
				emit_signal("hello")
			else:
			
				emit_signal("hi")


func _on_hitbox_area_entered(area):
	hihihi = true


func _on_hitbox_area_exited(area):
	hihihi = false


func _on_phb_area_entered(area):
	hihihi = true


func _on_phb_area_exited(area):
	hihihi = false

func _on_plr2_hi():
	v.y = -200
	whiffing = true
	whifftime = 30
	kb()

func _on_plr2_hello():
	v.y = -500
	whiffing = true
	whifftime = 50
	kb()

onready var plr2 = get_tree().get_root().get_node("Node2D/plr2")

func kb():
	if plr2.position.x > position.x:
		if harder:
			v.x = -500
			emit_signal("bigoof")
		else:
			v.x = -250
			emit_signal("oof")
	if plr2.position.x < position.x:
		if harder:
			v.x = 500
			emit_signal("bigoof")
		else:
			emit_signal("oof")
			v.x = 250


signal oof
signal bigoof


func _on_plr1_oof():
	pass # Replace with function body.
