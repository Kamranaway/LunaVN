extends Event
"""
Event.gd is the base class for all Events. Please
inherit Event.gd. 

Instantiating an event can be done using the new() function.
"""
class_name DialogEvent

var actor : Actor
var text
var dialog_box: Dialog

func _init(actor, text, dialog_box):
	self.actor = actor
	self.text = text
	self.dialog_box = dialog_box

func execute():
	dialog_box.get_config_from_actor(actor)
	dialog_box.queue_lines(text)
	await dialog_box.dialog_complete
	super()
