extends Stage

func stage_script():
	StageController.event_load_background("factory1")
	StageController.event_add_actor("Kyle")
	DialogEvent.new("Kyle", "Hi")
	DialogEvent.new("Kyle", "This is an event")
	DialogEvent.new("Kyle", "This is also an event")
	DialogEvent.new("Kyle", "This is the last event")
	
	StageController.load_event(8)
