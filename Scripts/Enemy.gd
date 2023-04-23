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
	
	if !in_hitstun:
		move_dir = self.global_position.direction_to(Global.player.global_position)
	
	velocity = move_dir * speed * delta
	
	if health <= 0:
		die()
	
	move_and_slide(velocity)

func die():
	queue_free()

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
