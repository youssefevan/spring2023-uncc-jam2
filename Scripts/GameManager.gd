extends Node2D

export (NodePath) var player_nodepath = null
export (NodePath) var camera_nodepath = null
export (NodePath) var starting_room_nodepath = null

var player
var camera

var starting_room
var current_room
var next_room
var previous_room

var switching : bool

func _ready():
	switching = false
	
	starting_room = get_node(starting_room_nodepath)
	current_room = starting_room
	
	player = get_node(player_nodepath)
	camera = get_node(camera_nodepath)

func _physics_process(delta):
	pass

func _on_Camera_room_switch(next_room_dir):
	Global.switching = true
	player.detect_input = false
	
	if next_room_dir == current_room.next_room_direction and current_room.progress_room != null:
		next_room = current_room.progress_room.instance()
	elif next_room_dir == current_room.prev_room_direction and current_room.prev_room_direction != null:
		next_room = current_room.prev_room.instance()
	else:
		next_room = current_room.this_room.instance()
	
	match next_room_dir:
		"left":
			next_room.global_position = current_room.global_position + Vector2(-camera.cam_move_dist, 0)
		"right":
			next_room.global_position = current_room.global_position + Vector2(camera.cam_move_dist, 0)
		"up":
			next_room.global_position = current_room.global_position + Vector2(0, -camera.cam_move_dist)
		"down":
			next_room.global_position = current_room.global_position + Vector2(0, camera.cam_move_dist)
		
	add_child(next_room)
	
	yield(get_tree().create_timer(camera.travel_time), "timeout")
	
	previous_room = current_room
	current_room = next_room
	
	previous_room.queue_free()
	
	player.detect_input = true
	Global.switching = false
