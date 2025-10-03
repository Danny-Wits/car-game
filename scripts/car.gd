extends VehicleBody3D

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
