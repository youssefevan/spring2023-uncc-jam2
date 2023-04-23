extends Node2D
var interacted = false
var active = false
func _ready():
	$InteractionArea/InteractPrompt.visible = false


func _input(event):
	if active == true:
		if Input.is_action_just_pressed("interact"):
			find_and_use_dialogue()
			interacted = true

func find_and_use_dialogue():
	var dialogue_player = get_node_or_null("DialoguePlayer")
	
	if dialogue_player:
		dialogue_player.play()

func _on_InteractionArea_body_entered(body):
	if body.name == 'Player':
		active = true
		$InteractionArea/InteractPrompt.visible = true
		if interacted == true:
			$InteractionArea/InteractPrompt.texture = load("res://Sprites/interaction2.png")

func _on_InteractionArea_body_exited(body):
	if body.name == 'Player':
		active = false
		$InteractionArea/InteractPrompt.visible = false
		
