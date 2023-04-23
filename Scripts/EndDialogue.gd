extends CanvasLayer

export(String, FILE, "*json") var dialogue_file

var dialogues = []
var currentDialogue = -1
var isDialogueActive = false



func _ready():
	$Wake.visible = false
	$Sleep.visible = false
	$NinePatchRect.visible = false

func play():
	if isDialogueActive:
		return
	
	dialogues = load_dialogues()
	
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
		isDialogueActive = false
		$Wake.visible = true
		$Sleep.visible = true
		return
	
	$NinePatchRect/Message.text = dialogues[currentDialogue]["text"]

func load_dialogues():
	var file = File.new()
	if file.file_exists(dialogue_file):
		file.open(dialogue_file, file.READ)
		return parse_json(file.get_as_text())


func _on_Timer_timeout():
	isDialogueActive = false
