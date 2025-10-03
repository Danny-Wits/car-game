extends StaticBody3D

var spawner: MultiplayerSpawner
func _ready():
	spawner = $"../MultiplayerSpawner"
	spawner.spawn_function = _spawn_enemy
	
func _spawn_enemy(_data):
	var enemy = preload("res://vehicle_body_3d.tscn").instantiate()
	return enemy
