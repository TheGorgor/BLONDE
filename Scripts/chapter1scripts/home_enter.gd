extends Area2D

var in_deadzone = false

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player": 
		in_deadzone = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		in_deadzone = false

func _process(delta: float) -> void:
	if in_deadzone and Input.is_action_just_pressed("interact"):
		get_tree().change_scene_to_file("res://Scenes/chapter1/chapter1home.tscn")
		
		
