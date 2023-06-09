class_name StageEvent


static func load_background(name):
	var callable = (func(name): StageController.Background.load_background(name)).bind(name)
	CustomEvent.new(callable)


static func skip_on_choice(stage_name, choice_index, choice_num, event_count):
	ConditionalEvent.new(stage_name, choice_index, choice_num, event_count)

static func dialog(actor_name: String, text: String):
	DialogEvent.new(actor_name, text)


static func response(actor_name:String, responses: Array[String]):
	ResponseEvent.new(actor_name, responses)


static func choice(choices: Array[String], duration = 0.0):
	ChoiceEvent.new(choices, duration)


static func narrate(text:String):
	DialogEvent.new("Narrator", text)

static func start_track(index):
	var callable = func(index): MusicPlayer.start_track(index).bind(index)
	CustomEvent.new(callable)


static func stop_track():
	var callable = func(): MusicPlayer.stop()
	CustomEvent.new(callable)


static func start_sfx(index):
	var callable = func(index): StageController.SFX_Player.start_sfx(index).bind(index)
	CustomEvent.new(callable)


static func stop_sfx():
	var callable = func(): StageController.stop()
	CustomEvent.new(callable)


static func load_stage(stage_name: String):
	var callable = (func(stage_name): StageController.load_stage(stage_name)).bind(stage_name)
	CustomEvent.new(callable)
