extends Event

class_name CustomEvent

var callable


func _init(callable: Callable):
	self.callable = callable
	self.on_load = callable
	super()


func start() -> Signal:
	callable.call()
	return super()
