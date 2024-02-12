extends Area2D

# keep track of distance so we can eventually destroy it
var travelled_distance = 0

func _physics_process(delta):
	# convention to make const all caps
	const SPEED = 1000
	const RANGE = 1200
	
	# we want the bullet to go in the direction from the gun
	var direction = Vector2.RIGHT.rotated(rotation) # Vector2.RIGHT is offered directly from Godot
	position += direction * SPEED * delta # delta makes this time dependent rather than frame dependent
	# delta needs to be applied manually to Area2D as opposed to CharacterBody2D movement functions which
	# get delta automatically
	
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free() # destroy the object


func _on_body_entered(body):
	queue_free() # will wait 1 frame before destroying object
	if body.has_method("take_damage"): # if it's a slime and not a tree
		body.take_damage()
