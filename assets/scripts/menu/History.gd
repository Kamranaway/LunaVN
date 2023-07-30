extends PopupPanel

func _ready():
	$Panel/MarginContainer/RichTextLabel.append_text(StageController.DialogBox.history)


func _on_popup_hide():
	queue_free()
