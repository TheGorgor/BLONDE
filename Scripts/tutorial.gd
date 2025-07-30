extends CharacterBody2D

var tutorial_finished = false

@export var SPEED = 80
@export var JUMP_FORCE = -200
@export var GRAVITY = 500

var start_position = position

@onready var game = $".."
@onready var restart_label = $"../RestartLabel"
@onready var laugh = $"../Collisions/Area2D/Laugh"
@onready var boost_area = $"../BOOST/Area2D"
@onready var boost_collected = $"../BOOST/Area2D/Collect"

@onready var after_collect_layer = $"../TileMap/Layer2"
@onready var after_collect_collision1 = $"../Collisions/after_collect1"

@onready var npc_talk_panel = $Camera2D/NPCTalk
@onready var npc_talk_label = $Camera2D/NPCTalk/talk
@onready var typing = $Camera2D/NPCTalk/Typing

var in_deadzone_restart = false
var in_deadzone_boost = false
var in_deadzone_npc = false

var talk_started = false
func _physics_process(delta):
	# Yerçekimi
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	if not npc_talk_panel.visible:
	# Yatay hareket
		var input_dir = Input.get_axis("ui_left", "ui_right")
		velocity.x = input_dir * SPEED

	# Zıplama
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_FORCE
	
	if in_deadzone_npc:
		if Input.is_action_just_pressed("interact"):
			if not talk_started:
				talk_started = true
				npc_talk_panel.visible = true
				typing.play()
				npc_talk_label.text = "Hello,"
				await get_tree().create_timer(1.2).timeout
				npc_talk_label.text = "Hello, you must leave."
				await get_tree().create_timer(1.25).timeout
				npc_talk_label.text = "Hello, you must leave. You shouldn't be here."
				await get_tree().create_timer(1.5).timeout
				npc_talk_label.text = "Goodbye."
				await get_tree().create_timer(1.1).timeout
				typing.stop()
				tutorial_finished = true
				await get_tree().create_timer(0.2).timeout
	
	if in_deadzone_restart:
		if Input.is_action_just_pressed("restart"): # Input Map'te "restart" = R ayarla
			position = start_position
			in_deadzone_restart = false
			restart_label.visible = false
			laugh.stop()
			
	
	if in_deadzone_boost:
		if Input.is_action_just_pressed("interact"):
			boost_area.visible = false
			SPEED = 150
			JUMP_FORCE = -225
			boost_collected.play ()
			in_deadzone_boost = false
			after_collect_layer.visible = true
			after_collect_collision1.disabled = false
	
	if tutorial_finished:
		game.visible = false
		await get_tree().create_timer(4.0).timeout
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
		
	# Hareketi uygula
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == self:
		restart_label.visible = true
		in_deadzone_restart = true
		laugh.play()


func _on_get_boost_body_entered(body: Node2D) -> void:
	if body == self:
		in_deadzone_boost = true
		 


func _on_npc_area_body_entered(body: Node2D) -> void:
	if body == self:
		in_deadzone_npc = true
