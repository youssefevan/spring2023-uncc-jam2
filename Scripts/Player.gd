extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 2500
var input : Vector2
var raw_input : Vector2
var detect_input : bool
var facing : String
var attacking : bool
var invulnerable : bool
var in_hitstun : bool

var health : int

func _ready():
	Global.player = self
	
	health = 3
	
	in_hitstun = false
	detect_input = true
	facing = "south"
	attacking = false
	invulnerable = false
	
	$Sword.visible = false
	$Sword/Hitbox/Collider.disabled = true
	$HealthBar.visible = false

func _physics_process(delta):
	if Global.switching == true:
		velocity = Vector2.ZERO
	
	if detect_input == true and attacking == false:
		input = get_input()
	elif detect_input == false and in_hitstun == false:
		input = Vector2.ZERO
	
	if input != Vector2.ZERO:
		velocity = input * speed * delta
	else:
		velocity = Vector2.ZERO
	
	if Input.is_action_just_pressed("attack") and attacking == false:
		if in_hitstun == false:
			attack()
	
	check_facing()
	animate()
	
	if health == 3:
		$HealthBar.frame = 3
		
	if health == 2:
		$HealthBar.frame = 2
		
	if health == 1:
		$HealthBar.frame = 1
		
	if health == 0:
		$HealthBar.frame = 0
	
	if health <= 0:
		die()
	
	move_and_slide(velocity)

func check_facing():
	if raw_input == Vector2(0, -1):
		facing = "north"
	if raw_input == Vector2(0, 1):
		facing = "south"
	if raw_input == Vector2(-1, 0):
		facing = "west"
	if raw_input == Vector2(1, 0):
		facing = "east"
	if raw_input == Vector2(-1, -1):
		facing = "north_west"
	if raw_input == Vector2(1, -1):
		facing = "north_east"
	if raw_input == Vector2(-1, 1):
		facing = "south_west"
	if raw_input == Vector2(1, 1):
		facing = "south_east"

func animate():
	if attacking == false:
		if input == Vector2.ZERO:
			match facing:
				"north":
					$Animator.play("IdleN")
				"south":
					$Animator.play("IdleS")
				"west":
					$Animator.play("IdleW")
				"east":
					$Animator.play("IdleE")
				"north_west":
					$Animator.play("IdleNW")
				"north_east":
					$Animator.play("IdleNE")
				"south_west":
					$Animator.play("IdleSW")
				"south_east":
					$Animator.play("IdleSE")
		else:
			match facing:
				"north":
					$Animator.play("WalkN")
				"south":
					$Animator.play("WalkS")
				"west":
					$Animator.play("WalkW")
				"east":
					$Animator.play("WalkE")
				"north_west":
					$Animator.play("WalkNW")
				"north_east":
					$Animator.play("WalkNE")
				"south_west":
					$Animator.play("WalkSW")
				"south_east":
					$Animator.play("WalkSE")

func attack():
	attacking = true
	input = Vector2.ZERO
	match facing:
			"north":
				$Animator.play("AttackN")
			"south":
				$Animator.play("AttackS")
			"west":
				$Animator.play("AttackW")
			"east":
				$Animator.play("AttackE")
			"north_west":
				$Animator.play("AttackNW")
			"north_east":
				$Animator.play("AttackNE")
			"south_west":
				$Animator.play("AttackSW")
			"south_east":
				$Animator.play("AttackSE")
	
	yield(get_tree().create_timer(.25), "timeout")
	attacking = false

func get_input():
	raw_input = Vector2.ZERO
	raw_input.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	raw_input.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	input = raw_input.normalized()
	
	return input

func set_active(active):
	set_physics_process(active)
	set_process(active)
	set_process_input(active)

func _on_Hurtbox_area_entered(area):
	if !invulnerable and !in_hitstun and Global.switching == false:
		if area.is_in_group("Enemy"):
			var dir_to_enemy = self.global_position.direction_to(area.global_position)
			get_hurt(dir_to_enemy)

func get_hurt(dir_to_enemy):
	var hitstun_time = 0.5
	hit_anim()
	show_health_bar()
	health -= 1
	detect_input = false
	in_hitstun = true
	invulnerable = true
	input = -dir_to_enemy
	yield(get_tree().create_timer(hitstun_time), "timeout")
	velocity = Vector2.ZERO
	in_hitstun = false
	invulnerable = false
	detect_input = true

func hit_anim():
	$Sprite.visible = false
	yield(get_tree().create_timer(.1), "timeout")
	$Sprite.visible = true
	yield(get_tree().create_timer(.1), "timeout")
	$Sprite.visible = false
	yield(get_tree().create_timer(.1), "timeout")
	$Sprite.visible = true
	yield(get_tree().create_timer(.1), "timeout")
	$Sprite.visible = true

func show_health_bar():
	$HealthBar.visible = true
	yield(get_tree().create_timer(1), "timeout")
	$HealthBar.visible = false

func die():
	pass
