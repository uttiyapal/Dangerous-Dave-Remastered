extends CharacterBody2D

@export var speed := 80.0

@export var bullet_scene : PackedScene

@onready var bullet_spawn = $BulletSpawn
@onready var shoot_timer = $ShootTimer

var direction := 1
var start_x := 0.0
@export var patrol_distance := 120.0

@onready var sprite = $AnimatedSprite2D

func _ready():

	sprite.play("Walk")
	start_x = global_position.x
	shoot_timer.timeout.connect(_shoot)

func _shoot():

	print("Monster fired!")

	var bullet = bullet_scene.instantiate()

	get_parent().add_child(bullet)

	bullet.global_position = bullet_spawn.global_position

	if direction > 0:
		bullet.direction = Vector2.RIGHT
		bullet.get_node("AnimatedSprite2D").flip_h = false
	else:
		bullet.direction = Vector2.LEFT
		bullet.get_node("AnimatedSprite2D").flip_h = true

func _physics_process(_delta):

	velocity.x = speed * direction
	move_and_slide()

	if global_position.x <= start_x - patrol_distance:
		direction = 1

	if global_position.x >= start_x + patrol_distance:
		direction = -1

	sprite.flip_h = direction < 0
