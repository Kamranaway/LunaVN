extends Event
"""
Event.gd is the base class for all Events. Please
inherit Event.gd. 

Instantiating an event can be done using the new() function.
"""
class_name ChoiceEvent

var _choices
var _choice_select : ChoiceSelect
var _duration = 0.0


func _init(choices, duration = 0.0):
	_choices = choices
	_choice_select = StageController.ChoiceSelect
	_duration = duration
	super()


func start() -> Signal:
	for choice_option in _choices:
		_choice_select.add_choice(choice_option)
	if (_duration > 0.0):
		_choice_select.add_choice_timer(_duration)
	await _choice_select.choice_complete
	return super()
