extends TextureButton

signal level_select(level)
export var level_id: int = 1

func _ready():
	$Label.text = str(level_id)

func _on_Level_button_pressed():
	emit_signal("level_select",level_id)
	
