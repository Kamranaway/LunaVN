extends Node

func add_actor(path):
	self.add_child(load(path).instantiate())
	
func get_actor(name):
	for actor in self.get_children():
		if actor.actor_name == name:
			return actor
