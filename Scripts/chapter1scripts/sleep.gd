extends Area2D

var in_deadzone = false

@export var slept_before = false

@onready var chapter1home = $"../.."
@onready var HomeSong = $"../../HomeSong"

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		in_deadzone = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		in_deadzone = false

func _process(delta: float) -> void:
	if not slept_before and in_deadzone and Input.is_action_just_pressed("interact"):
		slept_before = true
		HomeSong.stop()
		chapter1home.visible = false
		await get_tree().create_timer(4).timeout
		chapter1home.visible = true
