extends KinematicBody2D

var health : int

func _ready():
	health = 3

func _on_Hurtbox_area_entered(area):
	if area.is_in_group("Player"):
		var dir_to_player = self.global_position.direction_to(area.global_position)
		get_hurt(dir_to_player)

func get_hurt(dir_to_player):
	health -= 1
	
