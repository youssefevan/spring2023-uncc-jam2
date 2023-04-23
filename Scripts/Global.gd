extends Node

var room_a = preload("res://Scenes/Rooms/RoomA.tscn")
var room_b = preload("res://Scenes/Rooms/RoomB.tscn")
var room_c = preload("res://Scenes/Rooms/RoomC.tscn")
var room_d = preload("res://Scenes/Rooms/RoomD.tscn")

var rooms = [
	room_a,
	room_b,
	room_c,
	room_d
]

var player : KinematicBody2D
var switching : bool
var player_died : bool
var in_dialogue: bool

func _ready():
	in_dialogue = false
	switching = false
