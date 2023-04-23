extends CanvasLayer

export(String, FILE, "*json") var dialogue_file

var dialogues = []
var currentDialogue = -1
var isDialogueActive = false

func _ready():
	$NinePatchRect.visible = false

func play():
	if isDialogueActive:
		return
	
	dialogues = load_dialogues()
	
	turn_off_the_player()
	isDialogueActive = true
	$NinePatchRect.visible = true
	#currentDialogue = -1
	next_line()

func _input(event):
	if not isDialogueActive:
		return
	if event.is_action_pressed("interact"):
		next_line()


func next_line():
	currentDialogue += 1
	if currentDialogue >= len(dialogues):
		currentDialogue = -1
		$Timer.start()
		$NinePatchRect.visible = false
		turn_on_the_player()
		
		return
	
	$NinePatchRect/Message.text = dialogues[currentDialogue]["text"]

func load_dialogues():
	var file = File.new()
	if file.file_exists(dialogue_file):
		file.open(dialogue_file, file.READ)
		return parse_json(file.get_as_text())


func _on_Timer_timeout():
	isDialogueActive = false

func turn_on_the_player():
	
	var player = get_tree().get_root().find_node("Player", true, false)
	if player:
		player.set_active(true)

func turn_off_the_player():
	var player = get_tree().get_root().find_node("Player", true, false)
	if player:
		player.set_active(false)
