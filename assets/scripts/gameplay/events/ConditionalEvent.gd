extends Event
"""
Event.gd is the base class for all Events. Please
inherit Event.gd. 

Instantiating an event can be done using the new() function.
"""
class_name ConditionalEvent

var _key := "String"
var _value

func _init(event, ):
	super()

func start() -> Signal:
	
	return super()
