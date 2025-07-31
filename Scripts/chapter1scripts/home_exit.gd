extends Area2D

var in_deadzone = false

@onready var Bed = $"../../Bed/Area2D"
@onready var HomeSong = $"../../HomeSong"
var scene_file = "res://Scenes/chapter1/chapter1outside.tscn"

func _process(delta: float) -> void:
	if in_deadzone and Input.is_action_just_pressed("interact"):
		HomeSong.stop()
		await get_tree().create_timer(0.25).timeout
		get_tree().change_scene_to_file(scene_file)
	
	if Bed.slept_before:
		scene_file = "res://Scenes/chapter1/chapter1outside2.tscn"


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		in_deadzone = true


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		in_deadzone = false
