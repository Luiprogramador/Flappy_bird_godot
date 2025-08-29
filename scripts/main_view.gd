extends Node2D

@onready var bird: CharacterBody2D = $Bird
@onready var tutorial: TextureRect = $UILayer/Tutorial
@onready var game_over: TextureRect = $UILayer/GameOver
@onready var ground: StaticBody2D = $Ground
@onready var score_label: Label = $UILayer/ScoreLabel
@onready var restart: Button = $UILayer/Restart
@onready var timer: Timer = $Timer

var did_start_game: bool = false
var score: int = 0
var pipe = preload("res://cenas/pipes.tscn")

func _on_touch_area_did_touch() -> void:
	if did_start_game == false:
		start_game()
	if bird.has_method("did_touch"):
		bird.did_touch()

func start_game():
	did_start_game = true
	tutorial.visible = false
	pipes_generator()
func end_game():
	ground.stop_anim()
	restart.visible = true
	game_over.visible = true
	if bird.get_slide_collision_count() != 0:
		await get_tree().create_timer(0.5).timeout
		GameManager.is_game_playing = false
	timer.stop()

func pipes_generator():
	if did_start_game:
		var new_pipe = pipe.instantiate()
		new_pipe.position = Vector2(320, randf_range(95, 305))
		new_pipe.connect("score_up", did_score)
		call_deferred("add_child", new_pipe)
		new_pipe.z_index = -1
		timer.start(2.0)
		
func did_score():
	score += 1 
	score_label.text = str(score)


func _on_timer_timeout() -> void:
	if GameManager.is_game_playing:
		pipes_generator()



func _on_bird_did_died() -> void:
	end_game()
	

func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()
