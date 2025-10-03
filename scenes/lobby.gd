extends Control
const PORT:int = 9999
var peer:ENetMultiplayerPeer = ENetMultiplayerPeer.new()
@onready var ip_input: LineEdit = $UI/IpInput
@onready var name_input: LineEdit = $UI/NameInput

func _on_host_pressed() -> void:
	if peer.create_server(PORT) !=OK:
		print("Server not Created")
		return
	move_to_map()
	
func _on_join_pressed() -> void:
	var ip = ip_input.text.strip_edges()
	if ip.length()==0:
		ip="127.0.0.1"
	if peer.create_client(ip,PORT)!=OK:
		print("Client not connected")
		return
	move_to_map()

func move_to_map():
	Global.player_name=name_input.text.strip_edges()
	multiplayer.multiplayer_peer=peer
	get_tree().change_scene_to_file("res://scenes/map.tscn")
