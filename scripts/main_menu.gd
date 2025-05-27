extends Control

var start = false


func _process(delta):
	if start:
		$TextureButton.rotation += 0.8

func _on_texture_button_pressed():
	start = true
	$AnimationPlayer.play("start")
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://scenes/game.tscn")
