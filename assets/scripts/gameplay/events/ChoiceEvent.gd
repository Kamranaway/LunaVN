extends Event
"""
Event.gd is the base class for all Events. Please
inherit Event.gd. 

Instantiating an event can be done using the new() function.
"""
class_name ChoiceEvent

var choices
var choice_box : Choice
var duration = 0.0


func _init(choices, duration = 0.0):
	self.choices = choices
	self.choice_box = StageController.ChoiceBox
	self.duration = duration
	super()


func start() -> Signal:
	for choice_option in choices:
		choice_box.add_choice(choice_option)
	if (duration > 0.0):
		choice_box.add_choice_timer(duration)
		await choice_box.choice_complete
	return super()
