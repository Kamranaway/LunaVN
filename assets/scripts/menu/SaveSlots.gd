extends PopupPanel

@onready var top_row = $HBoxContainer/CenterContainer/MarginContainer/ScrollContainer/VBoxContainer/TopRow
@onready var bottom_row = $HBoxContainer/CenterContainer/MarginContainer/ScrollContainer/VBoxContainer/BottomRow
var save_slot = preload("res://assets/scenes/menu/SaveSlot.tscn")

const MAX_SAVE = 101
var saves = []


func _ready():
	check_saves()


func check_saves():
	for save in saves:
		save.queue_free()
	saves = []
	
	var j = 0
	for i in range(0, MAX_SAVE + 1):
		var save = save_slot.instantiate()
		saves.append(save)
		
		if j % 2 == 1:
			bottom_row.add_child(save)
		else:
			top_row.add_child(save)
		
		#check if index exists
		if StageData.save_exists(j):
			StageData.load_dict(j)
			
			save.tex_rect.texture = ImageTexture.create_from_image(StageData.current_image)
			
			save.label.text = (str(StageData.save_state_dict["date"]["month"]) + "/" + 
				str(StageData.save_state_dict["date"]["day"]) + "/" + str(StageData.save_state_dict["date"]["year"]) 
				+ " " + str(StageData.save_state_dict["time"]["hour"]) + ":" + str(StageData.save_state_dict["time"]["minute"])
				+ ":" + str(StageData.save_state_dict["time"]["second"]))
		
		save.save_id = j
		save.slot.text = "Slot " + str(j)	
		j += 1



func _on_save_button_down():
	self.visible = false
	StageController.Pause_Menu.visible = false
	#todo: find a better way to assure the UI isn't visible
	await get_tree().create_timer(0.1).timeout
	StageData.create_save(StageData.selected_slot)
	check_saves()
	self.visible = true
	StageController.Pause_Menu.visible = true


func _on_load_button_down():
	pass # Replace with function body.


func _on_delete_button_down():
	StageData.delete_save(StageData.selected_slot)
	check_saves()
