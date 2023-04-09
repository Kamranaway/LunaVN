extends Control

@onready var ActorName = $DialogRig/ActorName
@onready var DialogText = $DialogRig/MarginContainer/DialogMargin/DialogText
@onready var PointerAnimation = $DialogRig/MarginContainer/DialogMargin/Pointer/PointerAnimation
@onready var DialogRig = $DialogRig
@onready var TextSoundPlayer = $TextSoundPlayer

@export var _dialog_tween_duration := 1.0
@export var _fast_foward_velocity := 100 #characters per second
@export var _velocity := 15 #characters per second
@onready var _characters_visible := 0.0
@export var _start_descended = true

#Line length limit in pixels
@onready var _length_limit_px = ($DialogRig/MarginContainer.size.x - 
$DialogRig/MarginContainer/DialogMargin.size.x - DialogText.size.x)

var _line_queue = []
var _last_char_count = 0
var _tween

func _ready():
	DialogText.text = ""
	_tween = get_tree().create_tween()
	
	if (_start_descended):
		_tween.tween_property(DialogRig, "position:y", get_viewport_rect().size.y, 
		0).set_trans(Tween.TRANS_LINEAR)
		
		queue_lines("Hello. My name is Margot the fell omen Aeons ago my dad actually used to run a baseball shop in guam where he sold pokemon cards to stupid solicitors. They sure were stupid, but its not my problem anymore, lol.")
	
func _process(_delta):
	if _tween.is_running():
		return
	
	var delta_visible = (_fast_foward_velocity * _delta if
		Input.is_action_pressed("Next_Dialog") else _velocity * _delta)
		
	_characters_visible += delta_visible
	_characters_visible = clampf(_characters_visible, 0.0, DialogText.get_total_character_count())
	DialogText.set("visible_characters", _characters_visible)
	
	if(int(_characters_visible) > _last_char_count):
		TextSoundPlayer.play()
	
	if (_characters_visible >= DialogText.get_total_character_count()):
		PointerAnimation.play("PointerAnimation")
		if (Input.is_action_just_pressed("Next_Dialog")):
			_next_in_queue()
	else:
		PointerAnimation.stop()
	
	
	
	_last_char_count = int(_characters_visible)
	
#Queue lines for a single actor
func queue_lines(text):
	_box_up()
	_line_queue.clear()
	_line_queue = _break_into_lines(text) 
	_next_in_queue()
	
func _box_down():
	_tween = get_tree().create_tween()
	_tween.tween_property(DialogRig, "position:y", get_viewport_rect().size.y, 
	_dialog_tween_duration).set_trans(Tween.TRANS_LINEAR)
	
func _box_up():
	_tween = get_tree().create_tween()
	_tween.tween_property(DialogRig, "position:y", 0, _dialog_tween_duration).set_trans(Tween.TRANS_LINEAR)
	
func _next_in_queue():
	_characters_visible = 0
	DialogText.set("visible_characters", _characters_visible)
	
	if len(_line_queue) <= 0:
		_box_down()
		return
		
	DialogText.text = ""
	
	var content_height = DialogText.get_theme_font("normal_font").get_string_size(_line_queue[0], 
		HORIZONTAL_ALIGNMENT_LEFT, -1, DialogText.get_theme_font_size("normal_font_size")).y
		
	var box_height = ($DialogRig/MarginContainer.size.y - 
	$DialogRig/MarginContainer/DialogMargin.size.y - DialogText.size.y)
	
	var line_count = int(box_height/content_height)
	line_count = abs(line_count)
	
	if (len(_line_queue) < line_count):
		while (len(_line_queue) > 0):
			DialogText.text += _line_queue.pop_front()
			DialogText.text += "\n"
	
	for _i in range(line_count):
		if len(_line_queue) <= 0:
			break
		DialogText.text += _line_queue.pop_front()
		DialogText.text += "\n"

	pass
	
func _break_into_lines(text):
	var lines = []
	
	var current_line := ""
	var index := 0
	
	while len(text) > 0:
		current_line = text.left(index)
		
		var current_length_px = DialogText.get_theme_font("normal_font").get_string_size(current_line, 
		HORIZONTAL_ALIGNMENT_LEFT, -1, DialogText.get_theme_font_size("normal_font_size")).x
		
		if current_length_px > _length_limit_px:
			var _to_strip 
			
			while (text[index - 1] != ' '):
				index -= 1
				
			current_line = text.left(index)
			
			_to_strip = -(len(current_line) - 1)
			text = text.right(_to_strip)
			lines.append(current_line.left(-1))
			index = 0
			current_line = ""
		elif index == len(text):
			lines.append(current_line)
			text = ""
		
		index += 1
	return lines
