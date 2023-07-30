extends Control

@onready var history = preload("res://assets/scenes/menu/History.tscn")


func _ready():
	self.visible = false

func _on_save_button_down():
	$SaveSlots.visible = true

func _process(_delta):
	if Input.is_action_just_pressed("Menu") and len(StageController.stage_name) > 0:
		visible = !visible

func _on_load_button_down():
	$SaveSlots.visible = true


func _on_history_button_down():
	get_parent().add_child(history.instantiate())


func _on_options_button_down():
	pass # Replace with function body.


func _on_exit_button_down():
	get_tree().quit()
	

