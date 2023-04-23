extends Camera2D

signal room_switch(next_room_dir)

export (NodePath) var player_nodepath = null
var player

var can_switch : bool
var switching : bool
var switch_dist = 68
var cam_move_dist = 128
var new_pos : Vector2
var next_room_dir : String
var travel_time := .85

func _ready():
	global_position = Vector2(64, 64)
	player = get_node(player_nodepath)
	can_switch = true

func _physics_process(delta):
	room_switching()

func get_player_pos_from_center():
	var dist = Vector2()
	dist.x = player.global_position.x-global_position.x
	dist.y = player.global_position.y-global_position.y
	
	return dist

func room_switching():
	if get_player_pos_from_center().x <= -switch_dist: # exit left
		new_pos = global_position - Vector2(cam_move_dist, 0)
		next_room_dir = "left"
		room_transition()
	elif get_player_pos_from_center().x >= switch_dist: # exit right
		new_pos = global_position + Vector2(cam_move_dist, 0)
		next_room_dir = "right"
		room_transition()
	elif get_player_pos_from_center().y <= -switch_dist: #exit up
		new_pos = global_position - Vector2(0, cam_move_dist)
		next_room_dir = "up"
		room_transition()
	elif get_player_pos_from_center().y >= switch_dist: # exit down
		new_pos = global_position + Vector2(0, cam_move_dist)
		next_room_dir = "down"
		room_transition()

func room_transition():
	if can_switch == true:
		emit_signal("room_switch", next_room_dir)
		var tween = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(self, "global_position", new_pos, travel_time)
