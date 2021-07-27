extends KinematicBody2D

var playing = true
var character = 2
var up = Vector2.UP
var v = Vector2()
var mvmsp = 300
var blocking = false
var blocktime = 6
var facingRight = false
export var hitting = false
var crouchin = false
#collision
var rph = false
var lph = false
var spectimer = 10
var harder = 0

var whiffing = false
var whifftime = 60
func _physics_process(delta):
	#crouch mechanic HWUAIh ohuvahiuw hwauhi dhiu die
	if playing:
		if crouchin:
			if !hitting:
				$AnimationPlayer.play("crouch")
				v.x = 0
			else:
				pass
		if Input.is_action_pressed("crouch2"):
			if is_on_floor():
				crouchin = true
		if !Input.is_action_pressed("crouch2"):
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
				if Input.is_action_pressed("jump2"):
					v.y -= 700
					$AnimationPlayer.play("jump")
			else:
				$AnimationPlayer.play("jump")
			if facingRight:
				
				$Sprite.scale.x = 1
			else:
				
				
				$Sprite.scale.x = -1
			if Input.is_action_pressed("left2"):
				if !whiffing:
					if !crouchin:
						v.x = -mvmsp
						facingRight = false
						if is_on_floor():
							$AnimationPlayer.play("walk")
			elif Input.is_action_pressed("right2"):
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
			if Input.is_action_just_pressed("j2"):
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
						whiffing = true
						hitting = true
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
					whifftime = 5
			#kiik
			if Input.is_action_just_pressed("k2"):
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
		if Input.is_action_just_pressed("block2"):
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
		
		#special move(only 1)

		if Input.is_action_pressed("spec2"):
			if facingRight:
				$phb/CollisionShape2D.position.x = 14.277
				$phb/CollisionShape2D.position.y = 1.953
			else:
				$phb/CollisionShape2D.position.x = -14.277
				$phb/CollisionShape2D.position.y = 1.953
			harder = 3
			whiffing = true
			whifftime = 30
			$AnimationPlayer.play("speci")
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
			if harder == 3:
				emit_signal("cya")

signal bye
signal cya

func _on_plr1_bye():
	v.y = -250
	whiffing = true
	whifftime = 60
	emit_signal("oof")
func _on_plr1_hi():
	if !blocking:
		v.y = -200
		whiffing = true
		whifftime = 30
		kb()
	else:
		kb2()
		blocking = false

func _on_plr1_hello():
	if !blocking:
		v.y = -500
		whiffing = true
		whifftime = 50
		kb()
	else:
		kb2()
		blocking = false

onready var plr1 = get_tree().get_root().get_node("Node2D/plr1")

func kb():
	if plr1.position.x > position.x:
		if harder:
			v.x = -500
			emit_signal("oof")
		else:
			v.x = -250
			emit_signal("oof")
	if plr1.position.x < position.x:
		if harder:
			v.x = 500
			emit_signal("oof")
		else:
			emit_signal("bigoof")
			v.x = 250

func kb2():
	if plr1.position.x > position.x:
			v.x = -500
			v.y = -40
	if plr1.position.x < position.x:
			v.x = 500
			v.y = -40

signal oof
signal bigoof


func _on_Themaps_proceed():
	playing = true
