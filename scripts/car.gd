extends VehicleBody3D

@export var health: int = 5

@export var accelaration: float = 1500.0
@export var brake_force: float = 0.5
@export var ster_angle: float = 0.5
@onready var name_label: Label3D = $Name


func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())
func _ready() -> void:	
	name_label.text= Global.player_name if is_multiplayer_authority() else str(name)
	$SpringArm3D/Camera3D.current=is_multiplayer_authority()
	set_physics_process(is_multiplayer_authority())
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _physics_process(delta: float) -> void:
	steering = move_toward(steering,Input.get_axis("right","left")*ster_angle,delta*3.5)
		
	if Input.is_action_pressed("brake"):
		engine_force = -(accelaration *brake_force)

	if Input.is_action_pressed("forward"):
		engine_force = accelaration
	
	else:
		engine_force/=1.2
		
	if Input.is_action_just_pressed("shoot"):
		print("shoot pressed")
		shoot_bullet()


#func shoot_bullet():
	#const BULLET_3D = preload("res://scenes/fire_ball/bullet_3d.tscn")
	#var new_bullet = BULLET_3D.instantiate()
	#$Marker3D.add_child(new_bullet)
	#
	#new_bullet.global_transform =$Marker3D.global_transform

func shoot_bullet():
	print("shoot get called")
	#if multiplayer.is_server():
		#_spawn_bullet($Marker3D.global_transform)
	#else:
		#rpc_id(1, "request_bullet_spawn", $Marker3D.global_transform)
	rpc("request_bullet_spawn",$Marker3D.global_transform)

@rpc("any_peer","call_local")
func request_bullet_spawn(transforms: Transform3D):
	print("2nd call")
	#if multiplayer.is_server():
	_spawn_bullet(transforms)

func _spawn_bullet(transforms: Transform3D):
	print("3rd call")
	const BULLET_3D = preload("res://scenes/fire_ball/bullet_3d.tscn")
	var bullet = BULLET_3D.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.global_transform = transforms
