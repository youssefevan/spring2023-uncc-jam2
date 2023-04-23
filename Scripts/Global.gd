extends Node

var room_a = preload("res://Scenes/Rooms/RoomA.tscn")
var room_b = preload("res://Scenes/Rooms/RoomB.tscn")
var room_c = preload("res://Scenes/Rooms/RoomC.tscn")
var room_d = preload("res://Scenes/Rooms/RoomD.tscn")
var room_e = preload("res://Scenes/Rooms/RoomE.tscn")
var room_f = preload("res://Scenes/Rooms/RoomF.tscn")
var room_g = preload("res://Scenes/Rooms/RoomG.tscn")
var room_h = preload("res://Scenes/Rooms/RoomH.tscn")

var rooms = [
	room_a,
	room_b,
	room_c,
	room_d,
	room_e,
	room_f,
	room_g,
	room_h
]

var player : KinematicBody2D
var switching : bool
var player_died : bool
var in_dialogue: bool

func _ready():
	in_dialogue = false
	switching = false
