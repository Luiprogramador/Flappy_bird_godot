extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

const JUMP_VELOCITY = -450.0

signal did_died

var did_start_game: bool = false
var is_dead: bool = false

func _physics_process(delta: float) -> void:
	if get_slide_collision_count() != 0:
		death_action()
	# Add the gravity.
	if did_start_game:
		velocity += get_gravity() * delta
	move_and_slide()
	rotate_bird()
	# Handle jump.		
		


func did_touch():
	if did_start_game == false:
		did_start_game = true
		GameManager.is_game_playing = true
	if not is_dead:
		jump()


func jump():
	rotation = 0
	velocity.y = JUMP_VELOCITY

func death_action():
	if !is_dead:
		GameManager.is_game_playing = true
		is_dead = true
		anim.stop()
		emit_signal("did_died")
		
func rotate_bird():
	var target_rotation_degrees: float
	
	if velocity.y < 0:
		# Pássaro subindo, define o ângulo alvo para cima (por exemplo, -30 graus)
		target_rotation_degrees = -30
	elif velocity.y > 0:
		# Pássaro caindo, define o ângulo alvo para baixo (por exemplo, 50 graus)
		target_rotation_degrees = 50
	else:
		# Pássaro parado, volta para o ângulo 0
		target_rotation_degrees = 0
	
	# Interpolação para uma transição suave
	rotation_degrees = lerp(rotation_degrees, target_rotation_degrees, 0.1)
