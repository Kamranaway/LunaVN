extends Event

class_name ResponseEvent

var _actor_name : String
var _responses
var _dialog_box: Dialog


func _init(actor_name, responses):
	_actor_name = actor_name
	_responses = responses
	_dialog_box = StageController.DialogBox
	super()


func start() -> Signal:
	_dialog_box.get_config_from_actor(StageController.Actors.get_actor(_actor_name))
	_dialog_box.queue_lines(_responses[StageData.get_last_choice() - 1])
	print(_actor_name + ": " + _responses[StageData.get_last_choice() - 1])
	await _dialog_box.dialog_complete
	return super()
