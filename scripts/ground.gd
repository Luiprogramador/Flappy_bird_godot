extends StaticBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d.material.set_shader_parameter("speed", 0.28)

func stop_anim():
	sprite_2d.material.set_shader_parameter("speed", 0.0)
