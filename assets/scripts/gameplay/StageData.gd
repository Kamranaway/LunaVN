extends Node

var dir = DirAccess.open("user://Saves/")

var save_state_dict = {
	"date" : null,
	"time" : null,
	"current_stage" : null,
	"current_event" : null,
	"choice_data" : {},
	"image_data" : null
}

var current_image = null

var selected_slot = 0

const SAVE_DIRECTORY = "user://"
const SAVE_BASENAME = "SaveSlot_"
const SAVE_EXTENSION = ".save"
const STAGE_DIRECTORY = "res://assets/scenes/stages/"

func refresh_dict():
	current_image = get_viewport().get_texture().get_image()
	
	save_state_dict["date"] = Time.get_date_dict_from_system()
	save_state_dict["time"] = Time.get_time_dict_from_system()
	save_state_dict["current_stage"] = StageController.stage_name
	save_state_dict["current_event"] = StageController._event_index_counter #naming conventions go brrr
	save_state_dict["image_data"] = {'w': current_image.get_width(), 'h': current_image.get_height(), 'f': current_image.get_format()}

func create_save(index):
	refresh_dict()
	
	var save_data = FileAccess.open(SAVE_DIRECTORY + SAVE_BASENAME + str(index) + SAVE_EXTENSION, FileAccess.WRITE)
	var data_string = JSON.stringify(save_state_dict)
	
	#data length
	save_data.store_32(len(data_string))
	save_data.store_string(data_string)
	
	save_data.store_buffer(current_image.get_data())
	
	save_data.close()


func save_exists(index):
	return FileAccess.file_exists(SAVE_DIRECTORY + SAVE_BASENAME + str(index) + SAVE_EXTENSION)

#returns -1 if fails
func load_dict(index) -> int:
	if FileAccess.file_exists(SAVE_DIRECTORY + SAVE_BASENAME + str(index) + SAVE_EXTENSION):
		var file_bytes = FileAccess.get_file_as_bytes(SAVE_DIRECTORY + SAVE_BASENAME + str(index) + SAVE_EXTENSION)
		var header_length = file_bytes[0]
		
		for i in range(0, 4):
			file_bytes.remove_at(0)
			
		var string_data = file_bytes.slice(0, header_length)
		var image_data = file_bytes.slice(header_length, len(file_bytes))
		
		
		
		string_data = string_data.get_string_from_ascii()
		
		#var string_data: String = FileAccess.get_file_as_string(SAVE_DIRECTORY + SAVE_BASENAME + str(index) + SAVE_EXTENSION)
		save_state_dict = JSON.parse_string(string_data)
		
		current_image = Image.create_from_data(save_state_dict["image_data"]["w"], save_state_dict["image_data"]["h"],
			false, save_state_dict["image_data"]["f"], image_data)
		return 0
	else:
		return -1
		push_error("File not found: " + SAVE_DIRECTORY + SAVE_BASENAME + str(index) + SAVE_EXTENSION)


func load_save(index):
	if load_dict(index) == -1:
		return
	
	StageController.reset_stage()
	get_tree().change_scene_to_file(STAGE_DIRECTORY + save_state_dict["current_stage"] + ".tscn")
	StageController.load_event(save_state_dict["current_event"])
	refresh_dict()


func delete_save(index):
	DirAccess.remove_absolute(SAVE_DIRECTORY + SAVE_BASENAME + str(index) + SAVE_EXTENSION)


func save_choices(choices_made):
	save_state_dict["choice_data"][str(StageController.stage_name)] = choices_made
	print(save_state_dict["choice_data"])


func get_last_choice() -> int:
	print(save_state_dict["choice_data"][str(StageController.stage_name)])
	return 	save_state_dict["choice_data"][str(StageController.stage_name)][StageController.get_num_choices() - 1]
