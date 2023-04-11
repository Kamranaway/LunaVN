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


func _init(actor, text):
	self.actor = StageController.Actors.get_actor(actor)
	self.text = text
	self.dialog_box = StageController.DialogBox
	super()


func start() -> Signal:
	dialog_box.get_config_from_actor(actor)
	dialog_box.queue_lines(text)
	await dialog_box.dialog_complete
	return super()
