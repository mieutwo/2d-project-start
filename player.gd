extends CharacterBody2D

var health = 100.0

signal health_depleted

func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * 600
	move_and_slide() # Function from CharacterBody2D
	
	if velocity.length() > 0.0: # If player is moving
		%HappyBoo.play_walk_animation() # animation function defined from HappyBoo
	else:
		%HappyBoo.play_idle_animation()
		
		# get_node parameter is a file path
		# get_node("HappyBoo") same as $HappyBoo
			# if HappyBoo had a parent node, right click HappyBoo and click on
			# Access as Unique Name to make %HappyBoo work instead of $HappyBoo.
			# This is better for performance too. This only works within the scene though.
	
	const DAMAGE_RATE = 5.0
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		# delta prevents health being loss instantly, goes by frame
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health
		if health <= 0.0: # emit signal to game to display game over screen
			health_depleted.emit()
