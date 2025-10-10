extends Area3D

const SPEED = 55.0
const RANGE = 40.0


var travelled_distance = 0.0

func _physics_process(delta):
	position += -transform.basis.z * SPEED * delta
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()


func _on_body_entered(_body) -> void:
	const VFX = preload("res://assets/VFX/Scenes/VFX_puff_big.tscn")
	var vfx = VFX.instantiate()
	get_tree().current_scene.add_child(vfx)
	vfx.global_transform = $".".global_transform
	var anim_player = vfx.get_node("AnimationPlayer") 
	anim_player.play("hit")
	queue_free()
	
	#if body.has_method("take_damage"):
		#body.take_damage()
