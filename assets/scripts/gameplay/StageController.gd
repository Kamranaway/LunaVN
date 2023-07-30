extends Node

"""
Base Class for all stages

"""

signal stage_loaded

@onready var Actors = $Actors
@onready var Background = $Background
@onready var Weather = $Weather
@onready var SFX_Player = $SFXPlayer
@onready var Pause_Menu = $PauseMenu
@onready var ChoiceSelect = $ChoiceSelect
@onready var DialogBox = $Dialog
@onready var Transition = $Transition
#Music Player is a global
#Stage Data is a global

var stage_name = ""

var _event_queue = []
var _current_event = null
var _choices_made = []
var _event_index_counter = 0
var _stage_list = []

const STAGE_DIRECTORY = "res://assets/scenes/stages/"


func _ready():
	var dir = DirAccess.open(STAGE_DIRECTORY)
	var files = dir.get_files()
	
	for file in files:
		if file.ends_with(".tscn"):
			_stage_list.append(file)
	
	assert(len(_stage_list) > 0, "No stages found \n Please add a stage to " + dir.get_current_dir())

#dangerous
func wait_for_ready():
	while(true):
		if _get_all_nodes(self):
			break

func _get_all_nodes(node, ready = true) -> bool:
	for n in node.get_children():
		if n.get_child_count() > 0:
			if !n.ready:
				return false
				
			return _get_all_nodes(n, n.ready)
		else:
			if n.ready:
				return true
	return true


func _process(_delta):
	
	if Input.is_action_pressed("Skip"):
		Input.action_press("Next_Dialog")
		Engine.time_scale = 4.0
	else:
		Engine.time_scale = 1.0
	
	if (len(_event_queue) > 0 and _current_event == null):
		_event_index_counter += 1
		_current_event = _event_queue.pop_front()
		print("Event #" + str(_event_index_counter) + ": " + _current_event.get_script().get_path().get_basename().get_file())
		await _current_event.start()
		_current_event.queue_free()


func reset_stage():
	for actor in Actors.get_children():
		if actor.name != "Narrator":
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


func load_stage(stage_name: String):
	reset_stage()
	get_tree().change_scene_to_file(STAGE_DIRECTORY + stage_name + ".tscn")


func get_event_index_count() -> int:
	return _event_index_counter


func get_num_choices() -> int:
	return len(_choices_made)

func skip_event():
	_event_index_counter += 1
	return _event_queue.pop_front()
	
