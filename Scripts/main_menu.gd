extends Control

@onready var BlondeSong = $Blonde
@onready var DistordedSound = $Distorded
@onready var CreatorNameLabel = $CreatorNameLabel
@onready var GameNameLabel = $GameNameLabel
@onready var MainSong = $Menu
@onready var StartButton = $StartButton
@onready var MainMenu = $"."

func _on_ready() -> void:
	BlondeSong.play()
	await get_tree().create_timer(5.5).timeout
	CreatorNameLabel.visible = true
	await get_tree().create_timer(2).timeout
	CreatorNameLabel.visible = false
	await get_tree().create_timer(2.5).timeout
	GameNameLabel.modulate = Color(1, 1, 0)
	GameNameLabel.visible = true
	await get_tree().create_timer(1).timeout
	GameNameLabel.visible = false
	BlondeSong.stop()
	DistordedSound.play()
	await get_tree().create_timer(0.5).timeout
	DistordedSound.stop()
	await get_tree().create_timer(3).timeout
	MainSong.play()
	StartButton.visible = true
	CreatorNameLabel.visible = true
	GameNameLabel.visible = true

func _on_menu_finished() -> void:
	await get_tree().create_timer(1.25).timeout
	MainSong.play()
	

func _on_start_button_pressed() -> void:
	MainMenu.visible = false
	await get_tree().create_timer(1.25).timeout
	MainSong.stop()
	DistordedSound.play()
	await get_tree().create_timer(0.5).timeout
	DistordedSound.stop()
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://Scenes/chapter1/chapter1outside.tscn")
	
