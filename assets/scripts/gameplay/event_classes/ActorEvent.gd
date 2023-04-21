class_name ActorEvent


static func add_actor(name):
	var callable = (func(name): StageController.Actors.add_actor(name)).bind(name)
	CustomEvent.new(callable)


static func add_doll_part(actor_name, index):
	var callable = (func(actor_name, index): StageController.Actors.get_actor(actor_name
		).add_doll_part(index)).bind(actor_name, index)
	CustomEvent.new(callable)


static func clear_doll_parts(actor_name):
	var callable = (func(actor_name): StageController.Actors.get_actor(actor_name).clear_doll_parts(
		)).bind(actor_name)
	CustomEvent.new(callable)


static func interp_position(actor_name, new_pos: Vector2, delay = 1.0, trans_type: 
	Tween.TransitionType = Tween.TRANS_LINEAR, ease_type: Tween.EaseType = Tween.EASE_IN_OUT):
	
	var callable = (func(actor_name, new_pos, delay, trans_type, ease_type): 
		await StageController.Actors.get_actor(actor_name).interpolate_position(new_pos, delay, 
		trans_type, ease_type)).bind(actor_name, new_pos, delay, trans_type, ease_type)
	CustomEvent.new(callable)


static func set_position(actor_name, new_pos: Vector2):
	var callable = (func(actor_name, new_pos): StageController.Actors.get_actor(actor_name).set_position(new_pos)).bind(actor_name, new_pos)
	CustomEvent.new(callable)

static func set_pose(actor_name, index):
	var callable = (func(actor_name, index):  StageController.Actors.get_actor(actor_name).set_pose(index).bind(actor_name, index))
