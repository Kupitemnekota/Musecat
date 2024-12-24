extends Area2D


var start_position: Vector2
var mousepos: Vector2
var dragging: bool

var cat


# процессы перетаскивания
func _ready() -> void:
	start_position = self.position

func _process(delta):
	if dragging:
		mousepos = get_viewport().get_mouse_position()
		self.position = mousepos

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("left_key"):
		dragging = true
	if Input.is_action_just_released("left_key") and dragging:
		dragging = false


# столкновение с котиком
func _on_area_entered(area: Area2D) -> void:
	cat = area
	set_meta("cat_counter", get_meta("cat_counter") + 1)

func _on_area_exited(area: Area2D) -> void:
	set_meta("cat_counter", get_meta("cat_counter") - 1)

func _physics_process(delta: float) -> void:
	print(get_meta("cat_counter"))
	if Input.is_action_just_released("left_key"):
		self.position = start_position
