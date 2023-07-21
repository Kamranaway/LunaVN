extends Event
"""
ConditionalEvent.gd

Conditional Events will skip a specified number of events if a choice condition is not met
"""
class_name ConditionalEvent

var stage
var choice_index
var event_count
var choice

func _init(stage, choice_index, choice, event_count):
	self.stage = stage
	self.choice_index = choice_index
	self.choice = choice
	self.event_count = event_count
	super()

func start() -> Signal:
	if StageData.save_state_dict["choice_data"][stage][choice_index - 1] == choice:
		for i in range(event_count):
			var event = StageController.skip_event()
			if event is ChoiceEvent:
				StageController.append_choices(-1)
	return super()
