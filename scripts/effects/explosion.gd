extends Node2D

@onready var sprite = $AnimatedSprite2D
@onready var sound = $AudioStreamPlayer2D

func _ready():

	sprite.play("Explode")
	sound.play()

	sprite.animation_finished.connect(_on_finished)

func _on_finished():

	queue_free()
