extends Node

"""
Base Class for all stages

"""

@onready var Actors = $Actors
@onready var Background = $Background
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


func _process(_delta):
	if Input.is_action_just_pressed("Menu"):
		Pause_Menu.visible = !Pause_Menu.visible
	
	if (len(_event_queue) > 0 and _current_event == null):
		_current_event = _event_queue.pop_front()
		await _current_event.start()
		_current_event = null
		pass


func push_event(event: Event):
	_event_queue.append(event)


func add_actor(name):
	Actors.add_actor(name)


func load_background(name):
	Background.load_background(name)
