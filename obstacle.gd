extends CharacterBody2D

@onready var collision_check = $RayCast2D
@onready var obstacle = $"."
signal point

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if collision_check.is_colliding():
		point.emit()
		obstacle.queue_free()





func _on_point():
	return 1
