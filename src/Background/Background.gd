extends ParallaxBackground

export var can_scroll: bool = true
export var scroll_speed: float = 2.5

func _process(delta):
	if (!can_scroll):
		return
		
	scroll_offset.y += scroll_speed
