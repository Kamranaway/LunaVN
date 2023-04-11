extends Node

class_name Stage

var _stage_name := ""

func _ready():
	_stage_name = get_tree().current_scene.scene_file_path.get_file().get_basename()
	stage_script()

func stage_script():
	pass
