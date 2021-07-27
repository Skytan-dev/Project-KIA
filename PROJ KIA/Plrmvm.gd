extends KinematicBody2D

var playing = true
var character = 2
var up = Vector2.UP
var v = Vector2()
var mvmsp = 300
var blocking = false
var blocktime = 6
var facingRight = true
export var hitting = false
var crouchin = false
#collision
var rph = false
var lph = false

var harder = 0

var whiffing = false
var whifftime = 10
func _physics_process(delta):
	#crouch mechanic HWUAIh ohuvahiuw hwauhi dhiu die
	if playing:
		if crouchin:
			if !hitting:
				$AnimationPlayer.play("crouch")
				v.x = 0
			else:
				pass
		if Input.is_action_pressed("crouch"):
			if is_on_floor():
				crouchin = true
		if !Input.is_action_pressed("crouch"):
			crouchin = false
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
				if Input.is_action_pressed("jump"):
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
					if !crouchin:
						v.x = -mvmsp
						facingRight = false
						if is_on_floor():
							$AnimationPlayer.play("walk")
			elif Input.is_action_pressed("right"):
				if !whiffing:
					if !crouchin:
						v.x = mvmsp
						facingRight = true
						if is_on_floor():
							$AnimationPlayer.play("walk")
			else:
				if is_on_floor():
					v.x = 0
					if !whiffing:
						if !crouchin:
							$AnimationPlayer.play("idle")
				
		
		#jab
		if !whiffing:
			if Input.is_action_just_pressed("j"):
				if !crouchin:
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
						hitting = true
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
				else:
					harder = 2
					$AnimationPlayer.play("crouchpunch")
					if !facingRight:
						$phb/CollisionShape2D.position.x = -8.15
						$phb/CollisionShape2D.position.y = 9.36
					else:
						$phb/CollisionShape2D.position.x = 9.688
						$phb/CollisionShape2D.position.y = 9.36
					whiffing = true
					hitting = true
					whifftime = 10
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
		
		
		if !whiffing:
			blocking = false
		if Input.is_action_just_pressed("block"):
			
			if v.x > 0: v.x = 500
			elif v.x < 0: v.x = -500
			if !whiffing:
				$AnimationPlayer.play("block")
				blocking = true
				blocking = true
				blocktime = 6
				whiffing = true
				whifftime = 4
			else:
				whiffing = false
				$Sprite2.frame = 9
		
		if character == 1:
			if Input.is_action_just_pressed("spec"):
				whiffing = true
				whifftime = 200
				
				if facingRight:
					$AnimationPlayer.play("specal")
				else:
					$AnimationPlayer.play("specalleft")
		
		
		
		
		if character == 2:
			if Input.is_action_just_pressed("spec"):
				$AnimationPlayer.play("specison")
				whiffing = true
				whifftime = 200
				harder = 1
				if !facingRight:
						$phb/CollisionShape2D.position.x = -8.15
						$phb/CollisionShape2D.position.y = 9.36
				else:
						$phb/CollisionShape2D.position.x = 9.688
						$phb/CollisionShape2D.position.y = 9.36
					
		
		
		
		if whiffing == false: 
			$phb/CollisionShape2D.scale.x = 1
			$phb/CollisionShape2D.scale.y = 1
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
			if harder == 0:
				
				emit_signal("hi")
			if harder == 2:
				emit_signal("bye")

signal bye
signal peaceout
func _on_plr2_bye():
	v.y = -250
	whiffing = true
	whifftime = 60
	emit_signal("oof")
func _on_plr2_hi():
	if !blocking:
		v.y = -200
		whiffing = true
		whifftime = 30
		kb()
	else:
		kb2()
		blocking = false

func _on_plr2_hello():
	if !blocking:
		v.y = -500
		whiffing = true
		whifftime = 50
		kb()
	else:
		kb2()
		blocking = false

onready var plr2 = get_tree().get_root().get_node("Node2D/plr2")

func kb():
	if plr2.position.x > position.x:
		if harder:
			v.x = -500
			emit_signal("oof")
		else:
			v.x = -250
			emit_signal("oof")
	if plr2.position.x < position.x:
		if harder:
			v.x = 500
			emit_signal("oof")
		else:
			emit_signal("bigoof")
			v.x = 250
signal holyoof
func kb2():
	if plr2.position.x > position.x:
			v.x = -500
			v.y = -40
	if plr2.position.x < position.x:
			v.x = 500
			v.y = -40

func kb3():
	if plr2.position.x > position.x:
			v.x = -210
			v.y = -250
	if plr2.position.x < position.x:
			v.x = 210
			v.y = -250
signal oof
signal bigoof

func _on_plr2_cya():
	kb3()
	emit_signal("holyoof")
	


func _on_Themaps_proceed():
	playing = true
