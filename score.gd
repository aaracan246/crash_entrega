extends Label

@export var label_node_path: NodePath
@export var score_increase := 1      
@export var increase_interval := 1.0 

var score := 0
var _timer := 0.0
var _label: Label

func _ready() -> void:
	if label_node_path != NodePath():
		_label = get_node(label_node_path)
	update_label()

func _process(delta: float) -> void:
	_timer += delta
	if _timer >= increase_interval:
		_timer = 0.0
		score += score_increase
		update_label()

func update_label() -> void:
	if _label:
		_label.text = "Score: %d" % score
