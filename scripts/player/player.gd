extends CharacterBody2D

signal player_died

const SPEED := 100.0
const JUMP_FORCE := -250.0
const GRAVITY := 980.0
var facing_right := true

@export var bullet_scene: PackedScene

@onready var bullet_spawn = $BulletSpawn

var active_bullet: Node = null

func _physics_process(delta):

	# Gravity
	if !is_on_floor():
		velocity.y += GRAVITY * delta

	# Movement
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED
	
	if direction > 0:
		facing_right = true

	if direction < 0:
		facing_right = false

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_FORCE

	move_and_slide()
	
	if Input.is_action_just_pressed("confirm"):
		damage_player()
	
	if Input.is_action_just_pressed("shoot"):
		shoot()
	
func damage_player():

	GameManager.health -= 1

	print("Player took damage!")
	print("Health:", GameManager.health)
	
	if GameManager.health <= 0:
		die()

func take_damage(amount: int):

	for i in amount:
		damage_player()

func die():

	print("Player died!")

	GameManager.lives -= 1

	GameManager.health = GameManager.max_health

	if GameManager.lives <= 0:

		GameManager.lives = 0

		print("GAME OVER")

		return

	player_died.emit()

func respawn(spawn_position: Vector2):

	print("Respawning player.")

	global_position = spawn_position
	velocity = Vector2.ZERO

func shoot():

	if !GameManager.has_gun:
		return

	if active_bullet:
		return

	active_bullet = bullet_scene.instantiate()

	get_parent().add_child(active_bullet)

	active_bullet.global_position = bullet_spawn.global_position

	if facing_right:
		active_bullet.direction = Vector2.RIGHT
	else:
		active_bullet.direction = Vector2.LEFT

	active_bullet.bullet_destroyed.connect(_on_bullet_destroyed)

func _on_bullet_destroyed():
	active_bullet = null


	
	
	
	
	
	
	
