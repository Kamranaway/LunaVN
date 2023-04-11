extends Node
"""
Event.gd is the base class for all Events. Please
inherit Event.gd. 

Instantiating an event can be done using the new() function.
"""
class_name Event

signal event_complete

var on_load: Callable = func(): pass

func _init():
	StageController.push_event(self)


func start() -> Signal:
	call_deferred("emit_signal", "event_complete")
	return event_complete

func load() -> Signal:
	on_load.call()
	event_complete.emit()
	return event_complete
