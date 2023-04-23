extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
func _input(event):
	if Input.is_action_just_pressed("interact"):
		find_and_use_dialogue()

func find_and_use_dialogue():
	var dialogue_player = get_node_or_null("EndDialogue")
	
	if dialogue_player:
		dialogue_player.play()


func _on_Wake_pressed():
	get_tree().change_scene("res://Scenes/World.tscn")


func _on_Sleep_pressed():
	get_tree().change_scene("res://Scenes/StartScreen.tscn")
