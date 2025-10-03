extends VehicleBody3D


@export var accelaration: float = 1500.0
@export var brake_force: float = 0.5

@export var ster_angle: float = 0.5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	#var accel = 0.0
	#var ster = 0.0
	#engine_force = Input.get_axis("forward","brake")*accelaration
	steering = move_toward(steering,Input.get_axis("right","left")*ster_angle,delta*3.5)
		
	if Input.is_action_pressed("brake"):
		engine_force = -(accelaration *brake_force)

	if Input.is_action_pressed("forward"):
		engine_force = accelaration
	
	else:
		engine_force/=1.2
		
	#var lean_angle = -steering * 20 # degrees
	#$CSGBakedMeshInstance3D.rotation_degrees.z = lean_angle


#steering
	#if Input.is_action_pressed("left"):
		#ster=ster_angle
		#
	#elif Input.is_action_pressed("brake"):
		#ster = -ster_angle
		#
	##on wheels
	#for wheel in get_children():
		#if wheel is VehicleWheel3D:
			#if wheel.name.contains("Front"):
				#wheel.steering = ster.clamp(0,1)
				#wheel.engine_force = accel
