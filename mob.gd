extends CharacterBody2D


var health = 3

# store a reference to the player so we can detect collision
# get_node doesn't work here without @onready because it will run before the nodes are actually added to Game
# @onready waits until the game has added all nodes at runtime
@onready var player = get_node("/root/Game/Player")

func _ready():
	%Slime.play_walk()

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position) # most spirtes have a global_position
	velocity = direction * 300.0
	move_and_slide()

func take_damage():
	health -= 1
	%Slime.play_hurt()
	
	if health == 0:
		queue_free() # Deletes the node, which deletes the children
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke) # adds smoke to the parent of the deleted Mob node
		smoke.global_position = global_position # global position of the mob
