extends Node

export var room_number : int
export var next_room_direction : String
export var prev_room_direction : String

var progress_room
var this_room
var prev_room

func _ready():
	for i in Global.rooms:
		var temp_room = i.instance()
		if temp_room.room_number == room_number + 1:
			progress_room = i
		if temp_room.room_number == room_number:
			this_room = i
		if temp_room.room_number == room_number - 1:
			prev_room = i
