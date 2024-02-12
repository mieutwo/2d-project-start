extends Area2D

func _physics_process(delta):
	var enemies_in_range = get_overlapping_bodies() # gets bodies overlapping with gun's collision box
	
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range.front() # or [0]
		look_at(target_enemy.global_position)

func shoot():
	# preload means loaded at the start of the game
	const BULLET = preload("res://bullet.tscn") # load executes every time that line of code is executed
	var new_bullet = BULLET.instantiate() # create new instance of this scene
	new_bullet.global_position = %ShootingPoint.global_position # just position would be its position relative to the pistol
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)


func _on_timer_timeout():
	shoot()
