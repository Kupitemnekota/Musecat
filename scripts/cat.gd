extends Area2D


var current_instrument
var is_playing
var start_position
var cat_sprite
var in_area


func _ready() -> void:
	cat_sprite = self.find_child("cat_sprite")
	is_playing = false

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("left_key") and is_playing: # котик возвращает инструмент
		cat_sprite.animation = "sleep"
		current_instrument.visible = true
		current_instrument.position = start_position
		is_playing = false

func _on_area_entered(area: Area2D) -> void: # котику приходит инструмент
	if !is_playing: # сохраняет <настоящий> инструмент
		cat_sprite.modulate = "73af00" # ЗАМЕНИТЬ ПОДСВЕТКУ
		current_instrument = area
		start_position = $"../empty_sprites".find_child(current_instrument.name).position
		in_area = true

func _on_area_exited(area: Area2D) -> void: # от котика уходит инструмент
	cat_sprite.modulate = "ffffff" # ЗАМЕНИТЬ ПОДСВЕТКУ
	in_area = false

func _process(delta: float) -> void:
	if Input.is_action_just_released("left_key") and in_area: # котик получил инструмент
		if !is_playing:
			cat_sprite.animation = "playing_" + current_instrument.name
			is_playing = true
			in_area = false
			cat_sprite.modulate = "ffffff" # ЗАМЕНИТЬ ПОДСВЕТКУ
