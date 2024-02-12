extends Node2D

func _ready():
	spawn_mob()
	spawn_mob()
	spawn_mob()
	spawn_mob()
	spawn_mob()

func spawn_mob():
	# remember preload doesn't run each time, only once
	var new_mob = preload("res://mob.tscn").instantiate() # While holding scene, hold ctrl before dropping
	%PathFollow2D.progress_ratio = randf() # generates a random number between 0 and 1
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)


func _on_timer_timeout():
	spawn_mob()


func _on_player_health_depleted():
	%GameOver.visible = true
	get_tree().paused = true # get the root on runtime
