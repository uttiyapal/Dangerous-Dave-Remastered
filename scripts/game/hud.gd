extends CanvasLayer

@onready var score_label = $TopBar/ScoreLabel
@onready var life1 = $TopBar/LivesContainer/Life1
@onready var life2 = $TopBar/LivesContainer/Life2
@onready var life3 = $TopBar/LivesContainer/Life3
@onready var key_icon = $TopBar/KeyIcon
@onready var heart1 = $TopBar/HealthContainer/Heart1
@onready var heart2 = $TopBar/HealthContainer/Heart2
@onready var heart3 = $TopBar/HealthContainer/Heart3
@onready var gun_icon = $TopBar/GunIcon
@onready var jetpack_bar = $TopBar/JetpackBar
@onready var message_label = $MessageLabel

var message_id := 0

func _ready():
	jetpack_bar.min_value = 0
	jetpack_bar.max_value = GameManager.max_jetpack_fuel
	message_label.visible = false

func _process(_delta):
	score_label.text = "Score: %06d" % GameManager.score
	life1.visible = GameManager.lives >= 1
	life2.visible = GameManager.lives >= 2
	life3.visible = GameManager.lives >= 3
	key_icon.visible = GameManager.has_key
	heart1.visible = GameManager.health >= 1
	heart2.visible = GameManager.health >= 2
	heart3.visible = GameManager.health >= 3
	gun_icon.visible = GameManager.has_gun
	jetpack_bar.visible = GameManager.has_jetpack
	jetpack_bar.value = GameManager.jetpack_fuel

func show_message(text: String, duration: float = 2.0):
	message_id += 1
	var this_id = message_id

	message_label.text = text
	message_label.visible = true

	await get_tree().create_timer(duration).timeout

	if this_id == message_id:
		message_label.visible = false
