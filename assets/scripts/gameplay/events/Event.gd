"""
Event.gd is the base class for all Events. Please
inherit Event.gd. 

Instantiating an event can be done using the new() function.
"""
class_name Event

signal event_complete

func _init():
	StageController.push_event(self)

func start() -> Signal:
	emit_signal("event_complete")
	return event_complete
