@tool
extends  Node

class_name StageBase

func _ready():
	#StageController.stage_name = get_tree().current_scene.scene_file_path.get_file().get_basename()
	StageController.stage_name = self.get_script().get_path().get_basename().get_file()
	#StageController.stage_name = StageController.stage_name.replace(self.get_script().get_path().get_base_dir(), "")
	print("Stage Loaded: " + StageController.stage_name)
	stage_script()

func stage_script():
	pass


