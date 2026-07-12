extends Control

@onready var how_to_panel = $HowToPanel
@onready var menu = $VBoxContainer
@onready var torch1 = $AnimatedSprite2D
@onready var torch2 = $AnimatedSprite2D2
@onready var torch3 = $AnimatedSprite2D3
@onready var torch4 = $AnimatedSprite2D4
@onready var transition_anim = $TransitionLayer/AnimationPlayer

func _ready():
	for child in get_children():
		if child is AnimatedSprite2D:
			child.play("Burn")

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game/main.tscn")

func fade_out():
	transition_anim.play("FadeOut")
	await transition_anim.animation_finished

func _on_how_to_button_pressed():
	menu.visible = false
	how_to_panel.visible = true

func _on_quit_button_pressed():
	get_tree().quit()

func _on_back_button_pressed():
	how_to_panel.visible = false
	menu.visible = true
