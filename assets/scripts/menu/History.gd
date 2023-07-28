extends PopupPanel

func _ready():
	$Panel/MarginContainer/RichTextLabel.append_text(StageController.DialogBox.history)

func _on_button_button_down():
	self.queue_free()
