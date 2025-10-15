extends Node2D

@export var obstacle_scene: PackedScene
var holi = "holi"
# Intervalo entre spawns
@export var spawn_interval := 1.0

# Movimiento vertical
@export var fall_distance := 600.0
@export var fall_duration := 6.0

# Movimiento lateral
@export var side_offset := 150.0

var _timer := 0.0

func _process(delta: float) -> void:
	_timer += delta
	if _timer >= spawn_interval:
		_timer = 0.0
		spawn_obstacle()

func spawn_obstacle() -> void:
	if obstacle_scene == null:
		return

	var obstacle = obstacle_scene.instantiate()
	add_child(obstacle)

	# Posición base
	obstacle.global_position = global_position
	obstacle.scale = Vector2(0.5, 0.5)

	# Crear tween
	var tween = create_tween()

	# 🔹 Determinar dirección según el nombre del Spawner
	var direction := 0.0

	match name:
		"Spawner":  # Izquierda
			direction = -1.0
		"Spawner2":  # Derecha
			direction = 1.0
		"Spawner3": 
			direction = 1.0
		"Spawner4":
			direction = -1.0
		"Spawner5":
			direction = -1.0
		"Spawner6":
			direction = 1.0
		_:  # Otros
			direction = 0.0

	# Movimiento en Y 
	tween.tween_property(
		obstacle,
		"global_position:y",
		obstacle.global_position.y + fall_distance,
		fall_duration
	)

	# Movimiento lateral en X
	tween.parallel().tween_property(
		obstacle,
		"global_position:x",
		obstacle.global_position.x + (direction * side_offset),
		fall_duration
	)

	# Escalado del 50% al 100% (sensación de cercanía)
	tween.parallel().tween_property(
		obstacle,
		"scale",
		Vector2(1.0, 1.0),
		fall_duration
	)

	# Cheetos deletos
	tween.tween_callback(Callable(obstacle, "queue_free"))
