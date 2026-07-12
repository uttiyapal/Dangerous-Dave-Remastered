extends Area2D

@onready var sprite = $AnimatedSprite2D

func _ready():
	sprite.play("Idle")
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if !body.is_in_group("Player"):
		return

	if GameManager.health >= GameManager.max_health:
		return

	GameManager.health += 1
	get_tree().current_scene.play_pickup_sound()
	queue_free()
