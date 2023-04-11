extends Node

var dir = DirAccess.open("user://Saves/")
var save_state_dict = {
	"date" : "",
	"time" : "",
	"current_stage" : "",
	"current_event" : "",
	"choice_data" : {}
}

const SAVE_DIRECTORY = "user://"
const SAVE_BASENAME = "SaveSlot_"
const SAVE_EXTENSION = ".save"
const STAGE_DIRECTORY = "res://assets/scenes/stages/"

func create_save(index):
	save_state_dict["date"] = Time.get_date_dict_from_system()
	save_state_dict["time"] = Time.get_time_dict_from_system()
	save_state_dict["current_stage"] = StageController.stage_name
	save_state_dict["current_event"] = 0
	var save_data = FileAccess.open(SAVE_DIRECTORY + SAVE_BASENAME + str(index) + SAVE_EXTENSION, FileAccess.WRITE)
	save_data.store_string(JSON.stringify(save_state_dict))
	save_data.close()


func load_save(index):
	if FileAccess.file_exists(SAVE_DIRECTORY + SAVE_BASENAME + str(index) + SAVE_EXTENSION):
		var string_data: String = FileAccess.get_file_as_string(SAVE_DIRECTORY + SAVE_BASENAME + str(index) + SAVE_EXTENSION)
		save_state_dict = JSON.parse_string(string_data)
		StageController.reset_stage()
		get_tree().change_scene_to_file(STAGE_DIRECTORY + save_state_dict["current_stage"] + ".tscn")
		StageController.load_event(save_state_dict["current_event"])
		
		
	else:
		push_error("File not found: " + SAVE_DIRECTORY + SAVE_BASENAME + str(index) + SAVE_EXTENSION)


func delete_save(index):
	DirAccess.remove_absolute(SAVE_DIRECTORY + SAVE_BASENAME + str(index) + SAVE_EXTENSION)


func save_choices(choices_made):
	save_state_dict["choice_data"][str(StageController.stage_name)] = choices_made
	print(save_state_dict)
