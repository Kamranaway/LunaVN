extends Node

var _actor_list = []

const ACTOR_DIRECTORY = "res://assets/scenes/actors/"

func _ready():
	var dir = DirAccess.open(ACTOR_DIRECTORY)
	var files = dir.get_files()
	
	for file in files:
		_actor_list.append(file)
		assert(file.ends_with(".tscn"), file.get_basename() + " is not a scene")
	
	assert(len(_actor_list) > 0, "No actors found \n Please add an actor to " + dir.get_current_dir())


func get_actor(name):
	for actor in self.get_children():
		if actor.actor_name == name:
			return actor


func add_actor(name):
	for actor_file in _actor_list:
		if actor_file.get_basename() == name:
			self.add_child(load(ACTOR_DIRECTORY + actor_file).instantiate())
			return
	assert(false, "Actor " + name + " not found")


func does_actor_exist(name) -> bool:
	for actor_file in _actor_list:
		if actor_file.get_basename() == name:
			return true
	return false
