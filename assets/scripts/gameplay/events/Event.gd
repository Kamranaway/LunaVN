"""
Event.gd is the base class for all Events. Please
inherit Event.gd. 

Instantiating an event can be done using the new() function.
"""
class_name Event

signal event_complete

func execute():
	emit_signal("event_complete")
