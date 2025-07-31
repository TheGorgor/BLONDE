extends Area2D

@onready var camera = $"../../Player/Camera2D"
@onready var Player = $"../../Player"
@onready var TalkPanel = $"../../Player/Camera2D/TalkPanel"
@onready var TalkLabel = $"../../Player/Camera2D/TalkPanel/TalkLabel"
@onready var AdrianSong = $"../../AdrianSong"
@onready var Adrian = $"../../AnimatedSprite2D"

var in_deadzone = false

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and not in_deadzone:
		Adrian.play("idle")
		in_deadzone = true
		Player.can_move = false
		var x = 0
		while x < 200:
			x += 2  # her adımda 4 piksel kay
			camera.offset = Vector2(x, 0)
			await get_tree().create_timer(0.0125).timeout
		
		TalkPanel.visible = true
		await get_tree().create_timer(0.2).timeout
		TalkLabel.text = "Abigail, "
		await get_tree().create_timer(0.6).timeout
		TalkLabel.text = "Abigail, how many times have I "
		await get_tree().create_timer(0.7).timeout
		TalkLabel.text = "Abigail, how many times have I told you not to go out? "
		await get_tree().create_timer(0.8).timeout
		TalkLabel.text = "Abigail, how many times have I told you not to go out? \nIt's dangerous out there."
		await get_tree().create_timer(1.4).timeout
		TalkLabel.text = "You must "
		await get_tree().create_timer(0.4).timeout
		TalkLabel.text = "You must return home immediately."
		await get_tree().create_timer(0.8).timeout
		TalkLabel.text = "Abigail,"
		await get_tree().create_timer(2).timeout
		TalkLabel.text = "Abigail, do you know who I am?"
		await get_tree().create_timer(1.5).timeout
		TalkLabel.text = "Did you really think I was your boyfriend?"
		await get_tree().create_timer(3).timeout
		TalkLabel.text = "I think,"
		AdrianSong.play()
		await get_tree().create_timer(1.8).timeout
		TalkLabel.text = "I think, I need to do this to you."
		await get_tree().create_timer(2.25).timeout
		Adrian.play("run")
		Player.can_move = true
		TalkPanel.visible = false
		
		while x > 0:
			x -= 25
			camera.offset = Vector2(x, 0)
			await get_tree().create_timer(0.0125).timeout
			
			
