extends Area2D

var start_position # начальная позиция инструменты
var in_area = false # у котика
var dragging = false # перетаскивание
var mousepos

var cat
var cat_sprite
var cat_counter


# процессы перетаскивания
func _ready() -> void:
	start_position = self.position
	cat_counter = 0

func _process(delta):
	if dragging:
		mousepos = get_viewport().get_mouse_position()
		self.position = mousepos

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("left_key"):
			dragging = true
		elif Input.is_action_just_released("left_key") and dragging:
			dragging = false


# столкновение с котиком
func _on_area_entered(area: Area2D) -> void: # инструмент пришёл к котику
	cat_counter+=1
	cat = area
	cat_sprite = cat.find_child("cat_sprite")
	if cat_sprite.animation == "sleep" and cat_counter <= 1:
		in_area = true

func _on_area_exited(area: Area2D) -> void: # инструмент ушёл от котика
	cat_counter-=1
	in_area = false

func _physics_process(delta: float) -> void:
	print(cat_counter)
	if Input.is_action_just_released("left_key"): # отдать инстурмент котику
		if in_area:
			in_area = false
			self.visible = false
		else:
			self.position = start_position # возврат инструмента при уходе
