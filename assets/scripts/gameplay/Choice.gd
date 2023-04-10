extends CenterContainer

class_name Choice

@onready var choice_button = preload("res://assets/scenes/gameplay/ChoiceButton.tscn")
@onready var Choices := $Choices

var _num_choices = 0
var _timer

signal choice_complete


func add_choice(text, duration := 0.0):
	_num_choices += 1
	var new_choice = choice_button.instantiate()
	new_choice.text = text
	new_choice.connect("button_down", flush_choices.bind(_num_choices))
	Choices.add_child(new_choice)


func add_choice_timer(duration_sec):
	_timer = get_tree().create_timer(duration_sec)
	_timer.connect("timeout", flush_choices.bind(-1))


func flush_choices(index):
	_num_choices = 0
	for button in Choices.get_children():
		button.queue_free()
	_timer.disconnect("timeout", flush_choices.bind(-1))
	print(index)
	emit_signal("choice_complete")
