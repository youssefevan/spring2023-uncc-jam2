extends KinematicBody2D

var health : int
var move_dir : Vector2
var in_hitstun : bool
var velocity : Vector2

var speed = 1200

func _ready():
	health = 3

func _physics_process(delta):
	if Global.switching:
		speed = 0
	else:
		speed = 1200
	
	if Global.player_died == true:
		$Animator.playback_active = false
		self.set_physics_process(false)
	
	if Global.in_dialogue == true:
		move_dir = Vector2.ZERO
	else:
		if !in_hitstun:
			move_dir = self.global_position.direction_to(Global.player.global_position)
	
	
	velocity = move_dir * speed * delta
	
	if health <= 0:
		die()
	
	animate()
	
	move_and_slide(velocity)

func animate():
	var angle = move_dir.angle()
	var rad_angle = rad2deg(angle)
	if !in_hitstun:
		if rad_angle > -22.5 and rad_angle <= 22.5:
			$Animator.play("East")
		if rad_angle > 22.5 and rad_angle <= 67.5:
			$Animator.play("SouthEast")
		if rad_angle > 67.5 and rad_angle <= 112.5:
			$Animator.play("South")
		if rad_angle > 112.5 and rad_angle <= 157.5:
			$Animator.play("SouthWest")
		
		if rad_angle < -22.5 and rad_angle >= -65.7:
			$Animator.play("NorthEast")
		if rad_angle < -65.7 and rad_angle >= -112.5:
			$Animator.play("North")
		if rad_angle < -112.5 and rad_angle >= -157.5:
			$Animator.play("NorthWest")
		
		if rad_angle < -157.5 or rad_angle > 157.5:
			$Animator.play("West")
	

func die():
	call_deferred("free")

func _on_Hurtbox_area_entered(area):
	if area.is_in_group("Player"):
		var dir_to_player = self.global_position.direction_to(area.global_position)
		get_hurt(dir_to_player)

func get_hurt(dir_to_player):
	var hitstun_time = 0.5
	health -= 1
	in_hitstun = true
	move_dir = -dir_to_player
	hit_anim()
	yield(get_tree().create_timer(hitstun_time), "timeout")
	in_hitstun = false

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
