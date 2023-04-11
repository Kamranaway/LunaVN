extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	StageController.load_background("factory1")
	StageController.add_actor("TestActor")
	DialogEvent.new("TestActor", "Blue beans omg")
	DialogEvent.new("TestActor", "This is a dialog example")
	#ChoiceEvent.new(["Yes", "No"])
	#DialogEvent.new("TestActor", "I have simplified stage scripting uwu")
