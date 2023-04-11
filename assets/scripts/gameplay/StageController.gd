extends Node

"""
Base Class for all stages

"""

@onready var Actors = $Actors
@onready var Background = $Background
@onready var Weather = $Weather
@onready var SFX_Player = $SFXPlayer
@onready var Pause_Menu = $PauseMenu
@onready var ChoiceSelect = $ChoiceSelect
@onready var DialogBox = $Dialog
#Music Player is a global
#Stage Data is a global

var stage_name = ""

var _event_queue = []
var _current_event = null
var _choices_made = []
var _event_index_counter = 0


func _process(_delta):
	if Input.is_action_just_pressed("Menu"):
		Pause_Menu.visible = !Pause_Menu.visible
	
	if (len(_event_queue) > 0 and _current_event == null):
		_event_index_counter += 1
		_current_event = _event_queue.pop_front()
		await _current_event.start()
		_current_event.queue_free()

func reset_stage():
	for actor in Actors.get_children():
		actor.queue_free()

func load_event(index):
	_event_index_counter += 1
	while _event_index_counter < index:
		_event_queue.pop_front().load()
		_event_index_counter += 1
		

func push_event(event: Event):
	_event_queue.append(event)


func append_choices(new_choice):
	_choices_made.append(new_choice)
	StageData.save_choices(_choices_made)


func event_add_actor(name):
	var callable = (func(name): StageController.Actors.add_actor(name)).bind(name)
	CustomEvent.new(callable)


func event_load_background(name):
	var callable = (func(name): StageController.Background.load_background(name)).bind(name)
	CustomEvent.new(callable)
