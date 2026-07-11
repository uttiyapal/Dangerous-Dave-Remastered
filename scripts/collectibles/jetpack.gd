extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):

	if body.is_in_group("Player"):

		GameManager.has_jetpack = true

		get_tree().current_scene.play_pickup_sound()

		queue_free()
