extends Event
"""
Event.gd is the base class for all Events. Please
inherit Event.gd. 

Instantiating an event can be done using the new() function.
"""
class_name ChoiceEvent

var choices
var choice : Choice
var duration = 0.0

func _init(choices, choice, duration = 0.0):
	self.choices = choices
	self.choice = choice
	self.duration = duration

func execute():
	for choice_option in choices:
		choice.add_choice(choice_option)
	choice.add_choice_timer(duration)
	await choice.choice_complete
	super()
