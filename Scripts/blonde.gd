extends CharacterBody2D

@export var SPEED = 80
@export var JUMP_FORCE = -200
@export var GRAVITY = 600 

@export var can_move = true

func _physics_process(delta):
	# Yerçekimi (her zaman çalışır)
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	if can_move:
		# Koşma
		if Input.is_action_just_pressed("run"):
			SPEED = 135
		if Input.is_action_just_released("run"):
			SPEED = 80

		# Yatay hareket
		var input_dir = Input.get_axis("ui_left", "ui_right")
		velocity.x = input_dir * SPEED

		# Zıplama
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_FORCE
	else:
		# Yalnızca yatay hareketi durdur
		velocity.x = 0
		# Zıplamayı zaten yukarıdaki blok dışında bıraktığımız için engellendi

	# Hareketi uygula
	move_and_slide()
