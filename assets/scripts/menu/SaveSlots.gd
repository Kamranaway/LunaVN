extends PopupPanel


# Called when the node enters the scene tree for the first time.
func _ready():
	$ScrollContainer.custom_minimum_size.y = get_viewport().size.y
	$ScrollContainer.custom_minimum_size.x = get_viewport().size.x/4
