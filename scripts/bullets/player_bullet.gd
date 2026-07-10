extends Area2D

signal bullet_destroyed

@export var speed := 600.0

var direction : Vector2 = Vector2.RIGHT

@onready var sprite = $AnimatedSprite2D
@onready var notifier = $VisibleOnScreenNotifier2D

func _ready():
	sprite.play("Idle")
	
	body_entered.connect(_on_body_entered)
	notifier.screen_exited.connect(_on_screen_exited)

func _physics_process(delta):

	position += direction * speed * delta
	sprite.flip_h = direction.x < 0

func _on_body_entered(body):

	# Ignore the player
	if body.is_in_group("Player"):
		return

	if body.is_in_group("Monster"):
		body.take_damage(1)

	bullet_destroyed.emit()
	queue_free()

func _on_screen_exited():

	bullet_destroyed.emit()
	queue_free()
