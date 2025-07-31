extends Node

@onready var HomeSong = $HomeSong
@onready var Bed = $Bed/Area2D

func _on_ready() -> void:
	await get_tree().create_timer(0.5).timeout
	if not Bed.slept_before:
		HomeSong.play()
	


func _on_home_song_finished() -> void:
	await get_tree().create_timer(1).timeout
	HomeSong.play()
