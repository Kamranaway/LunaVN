extends Node

"""
Base Class for all stages

"""

class_name Stage

@onready var Actors = $Actors
@onready var Setting = $Setting
@onready var Weather = $Weather
@onready var SFX_Player = $SFXPlayer
@onready var Pause_Menu = $PauseMenu
@onready var ChoiceBox = $Choice
@onready var DialogBox = $Dialog
#Music Player is a global

@export var stage_name = ""

var _event_queue = []
var _current_event = null

var choices = ["One", "Two", "Three"]

func _ready():
	Actors.add_actor("res://assets/scenes/gameplay/actors/TestActor.tscn")
	_event_queue.append(DialogEvent.new(Actors.get_actor("TestActor"), "Hello world!", DialogBox))
	_event_queue.append(ChoiceEvent.new(choices, ChoiceBox, 3))
	_event_queue.append(DialogEvent.new(Actors.get_actor("TestActor"), "Hello world!", DialogBox))
	


func _process(_delta):
	if Input.is_action_just_pressed("Menu"):
		Pause_Menu.visible = !Pause_Menu.visible
	
	if (len(_event_queue) > 0 and _current_event == null):
		_current_event = _event_queue.pop_front()
		_current_event.execute()
		await _current_event.event_complete
		_current_event = null
