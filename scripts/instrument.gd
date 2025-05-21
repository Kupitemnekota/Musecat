extends Area2D


@onready var MusicPlayer = $MusicPlayer
@onready var InstrumentSprite = $Sprite

var start_position: Vector2
var mousepos: Vector2
var dragging: bool

@export var cat_counter: int = 0
@export var instrument: String
@export var is_playing: bool = false
var path_to_sprites = "res://sprites/instruments/"
var path_to_music = "res://music/"


var cat


# процессы перетаскивания
func _ready() -> void:
	start_position = self.position
	InstrumentSprite.texture = load(path_to_sprites + instrument + ".png")
	MusicPlayer.stream = load(path_to_music + instrument + ".mp3")
	MusicPlayer.volume_db = -100.0
	MusicPlayer.play()

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
	cat_counter += 1

func _on_area_exited(area: Area2D) -> void:
	cat_counter -= 1

func _physics_process(delta: float) -> void:
	if Input.is_action_just_released("left_key"):
		self.position = start_position

func toggle_music():
	if is_playing:
		MusicPlayer.volume_db = 0.0
	else:
		MusicPlayer.volume_db = -100.0
