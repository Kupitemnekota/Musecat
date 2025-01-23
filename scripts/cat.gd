extends Area2D


var cat_sprite
var in_area: bool
var current_instrument


signal return_instrument
signal get_instrument


func _ready() -> void:
	cat_sprite = self.find_child("cat_sprite")
	in_area = false

func _on_area_entered(area: Area2D) -> void:
	if !get_meta("is_playing"):
		in_area = true
		current_instrument = area

func _on_area_exited(area: Area2D) -> void:
	in_area = false
	cat_sprite.modulate = "ffffff" # ЗАМЕНИТЬ ПОДСВЕТКУ

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	# Возврат инструмента
	if Input.is_action_just_pressed("left_key") and get_meta("is_playing"):
		_on_return_instrument()
	
	# Получение инструмента
	if Input.is_action_just_released("left_key") and !get_meta("is_playing") and in_area:
		_on_get_instrument()


# Наведение мыши на кота
func _on_mouse_entered() -> void:
	if in_area:
		cat_sprite.modulate = "73af00" # ЗАМЕНИТЬ ПОДСВЕТКУ

func _on_mouse_exited() -> void:
	cat_sprite.modulate = "ffffff" # ЗАМЕНИТЬ ПОДСВЕТКУ


# Сигналы для обработки инструментов
func _on_return_instrument() -> void:
	cat_sprite.animation = "sleep"
	current_instrument.visible = true
	set_meta("is_playing", false)

func _on_get_instrument() -> void:
	current_instrument.visible = false
	cat_sprite.animation = "playing_" + current_instrument.name
	set_meta("is_playing", true)
