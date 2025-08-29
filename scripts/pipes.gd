extends Area2D

var SPEED = 90
const direction = Vector2.LEFT


var velocity = Vector2.ZERO
var velocity_max = Vector2.ONE
var did_emit: bool = false

signal score_up

func _physics_process(delta):
	if GameManager.is_game_playing:
		velocity = direction * SPEED
		position += velocity * delta
		
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Bird"):
		if did_emit == false:
			emit_signal("score_up")
			did_emit = true
