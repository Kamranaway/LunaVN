extends Control


func _on_start_button_down():
	Events.transition_out()
	await StageController.Transition.transition_complete
	Events.load_stage("TestStage1")


func _on_load_button_down():
	$SaveSlots.visible = true


func _on_options_button_down():
	pass # Replace with function body.


func _on_exit_button_down():
	get_tree().quit()
